Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C3AC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 23:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E5220721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 23:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgAJXlE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 18:41:04 -0500
Received: from d.mail.sonic.net ([64.142.111.50]:39162 "EHLO d.mail.sonic.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727544AbgAJXlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 18:41:04 -0500
X-Greylist: delayed 637 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jan 2020 18:41:03 EST
Received: from [10.0.2.187] (96-74-112-17-static.hfc.comcastbusiness.net [96.74.112.17] (may be forged))
        (authenticated bits=0)
        by d.mail.sonic.net (8.15.1/8.15.1) with ESMTPSA id 00ANUHkl000977
        (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Jan 2020 15:30:17 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] hcidump: add support for time64 based libc
From:   Guy Harris <guy@alum.mit.edu>
In-Reply-To: <20200110204903.3495832-1-arnd@arndb.de>
Date:   Fri, 10 Jan 2020 15:30:16 -0800
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Rich Felker <dalias@libc.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <25105A85-A3EE-4E6A-AAF5-D54FCF9E6ACB@alum.mit.edu>
References: <20200110204903.3495832-1-arnd@arndb.de>
To:     Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-Sonic-CAuth: UmFuZG9tSVYIRA+fNi8b3r1FssOT4xb63Qyki99RI6nrAU9tYdzqDLDLe2S+qpusOShKFEAJrb7Op0dy2QU0Tz6fs25ZO/1A
X-Sonic-ID: C;/GOrKAE06hGTPNIUGYmBQg== M;OHLjKAE06hGTPNIUGYmBQg==
X-Sonic-Spam-Details: 0.0/5.0 by cerberusd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 10, 2020, at 12:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> diff --git a/monitor/hcidump.c b/monitor/hcidump.c
> index 8b6f846d3..6d2330287 100644
> --- a/monitor/hcidump.c
> +++ b/monitor/hcidump.c
> @@ -107,6 +107,36 @@ static int open_hci_dev(uint16_t index)
> 	return fd;
> }
> 
> +static struct timeval hci_tstamp_read(void *data)
> +{
> +	struct timeval tv;
> +
> +	/*
> +	 * On 64-bit architectures, the data matches the timeval
> +	 * format. Note that on sparc64 this is different from
> +	 * all others.
> +	 */
> +	if (sizeof(long) == 8) {
> +		memcpy(&tv, data, sizeof(tv));
> +	}
> +
> +	/*
> +	 * On 32-bit architectures, the timeval definition may
> +	 * use 32-bit or 64-bit members depending on the C
> +	 * library and architecture.
> +	 * The cmsg data however always contains a pair of
> +	 * 32-bit values. Interpret as unsigned to make it work
> +	 * past y2038.
> +	 */
> +	if (sizeof(long) == 4) {
> +		unsigned int *stamp = data;
> +		tv.tv_sec = stamp[0];
> +		tv.tv_usec = stamp[1];
> +	}
> +
> +	return tv;
> +}

Should it be something more like

	if (sizeof(long) == 8) {
		/*
		 * On 64-bit architectures, the data matches the timeval
		 * format. Note that on sparc64 this is different from
		 * all others.
		 */
		memcpy(&tv, data, sizeof(tv));
	} else if (sizeof(long) == 4) {
		/*
		 * On 32-bit architectures, the timeval definition may
		 * use 32-bit or 64-bit members depending on the C
		 * library and architecture.
		 * The cmsg data however always contains a pair of
		 * 32-bit values. Interpret as unsigned to make it work
		 * past y2038.
		 */
		unsigned int *stamp = data;
		tv.tv_sec = stamp[0];
		tv.tv_usec = stamp[1];
	} else {
		abort();	/* or some other "sorry, we're not ready for 128-bit or weird architectures yet" failure */
	}

	return tv;

> static void device_callback(int fd, uint32_t events, void *user_data)
> {
> 	struct hcidump_data *data = user_data;
> @@ -150,7 +180,7 @@ static void device_callback(int fd, uint32_t events, void *user_data)
> 				memcpy(&dir, CMSG_DATA(cmsg), sizeof(dir));
> 				break;
> 			case HCI_CMSG_TSTAMP:
> -				memcpy(&ctv, CMSG_DATA(cmsg), sizeof(ctv));
> +				ctv = hci_tstamp_read(CMSG_DATA(cmsg));
> 				tv = &ctv;
> 				break;
> 			}

And libpcap's Linux BT code should do the same thing, changing its memcpy() call?

If you want, you can submit a pull request, or I can make the change.

