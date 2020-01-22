Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5179C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868F624655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5AVwkUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgAVThm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:37:42 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35074 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVThm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 14:37:42 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so229697plt.2;
        Wed, 22 Jan 2020 11:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ON8PJR5r3xQ8JwBGbw7JRK/vHHibNpurM3r0DvPXsXk=;
        b=u5AVwkUIzYsH20f10VYhX7TYzZxjZtZ2LQvTi06oFwvi1elLedTCmv/UfqQ9ojUPf3
         ef6nwsf0NE08Qxfy/aVpFWGjsWsRh7EZ3RzbjuGTLAJiJbS4U26w9kGcXsbAkhyTyvJc
         EadThNoAvmuHjFix1nDpw7rjRWwD+kjXH2C8ddq107084BQYRwHo6PE/ETuuz//V26us
         34SAtSpfbcm7nwWfQJDb4ZRDHFfJUCgxMuNITEIbekuBQGIKxnPiykp7HCAszFLbpq1x
         iqbDhoiQVmDpwkdv3kR5OcrxCH/kZMU40YIh+zV1zuvsIM/4fsxZmQr4od8oYxM/3LAS
         ZQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ON8PJR5r3xQ8JwBGbw7JRK/vHHibNpurM3r0DvPXsXk=;
        b=YMBtEfEk3EZKSz6GimWDjnOsssyJm02AMxo9ilA0PfYTTwO740cfFZUCsgvO/682P3
         nmdQDjhvwr4eYP73sJ3jHEHbJBF23OA2mc3bdYEQdQ9vNqXTxNQEz6VK9wgPFWIFoIuD
         rbVnuPDm4S05xzEA2y+kKOfKU4ucsBJ9z1aPSHmOLFnY9ZRkFxC6ctDr1OEtF363CB+M
         L7mNg6EEXZWEdo+67sAqolsev8Cdj/nPiBFeG3E9YxrXk4jHJXH1PbEqmmijp2udsgfB
         vV1Nil3ex1ChvzV+4lszCAf+onQp63KkCqEYS0v2JNM5N8RCkeH1OpOncrfG/dL9HaOr
         2ZZg==
X-Gm-Message-State: APjAAAXn11g3E6MxffntFu1WJBtR1Z6U7wQCRb3eLe+heDTna0O9yFoN
        x44u+I9UfQQa8QDDDLXtBg8=
X-Google-Smtp-Source: APXvYqxHnY4JoRCY6pGw7WqFIvaj2QkhUPNlC0akT9CN62frr+hDYC64bnIfz14kOs2iQX+MXaSWCw==
X-Received: by 2002:a17:90a:fb4f:: with SMTP id iq15mr53339pjb.86.1579721861802;
        Wed, 22 Jan 2020 11:37:41 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u23sm47660318pfm.29.2020.01.22.11.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jan 2020 11:37:41 -0800 (PST)
Date:   Wed, 22 Jan 2020 11:37:39 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Brad Campbell <lists2009@fnarfbargle.com>,
        Ondrej =?utf-8?Q?=C4=8Cerman?= <ocerman@sda1.eu>,
        Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        Michael Larabel <michael@phoronix.com>,
        Jonathan McDowell <noodles@earth.li>,
        Ken Moffat <zarniwhoop73@googlemail.com>,
        Darren Salt <devspam@moreofthesa.me.uk>
Subject: Re: [PATCH v4 0/6] hwmon: k10temp driver improvements
Message-ID: <20200122193739.GA22685@roeck-us.net>
References: <20200122160800.12560-1-linux@roeck-us.net>
 <20200122190508.tudp3gjscsxyidhw@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200122190508.tudp3gjscsxyidhw@earth.universe>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 08:05:08PM +0100, Sebastian Reichel wrote:
> Hi,
> 
> The series is
> 
> Tested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
Thanks again!

Guenter

> on 3800X.
> 
> idle:
> 
> k10temp-pci-00c3
> Adapter: PCI adapter
> Vcore:       919.00 mV
> Vsoc:          1.01 V
> Tdie:         +41.1°C
> Tctl:         +41.1°C
> Tccd1:        +39.8°C
> Icore:         0.00 A
> Isoc:          4.50 A
> 
> with load:
> 
> k10temp-pci-00c3
> Adapter: PCI adapter
> Vcore:         1.29 V
> Vsoc:          1.01 V
> Tdie:         +80.4°C
> Tctl:         +80.4°C
> Tccd1:        +78.5°C
> Icore:        61.00 A
> Isoc:          6.50 A
> 
> debugfs output is also register dumps are also working.
> 
> -- Sebastian
> 
> On Wed, Jan 22, 2020 at 08:07:54AM -0800, Guenter Roeck wrote:
> > This patch series implements various improvements for the k10temp driver.
> > 
> > Patch 1/6 introduces the use of bit operations.
> > 
> > Patch 2/6 converts the driver to use the devm_hwmon_device_register_with_info
> > API. This not only simplifies the code and reduces its size, it also
> > makes the code easier to maintain and enhance. 
> > 
> > Patch 3/6 adds support for reporting Core Complex Die (CCD) temperatures
> > on Zen2 (Ryzen and Threadripper) CPUs (note that reporting is incomplete
> > for Threadripper CPUs - it is known that additional temperature sensors
> > exist, but the register locations are unknown).
> > 
> > Patch 4/6 adds support for reporting core and SoC current and voltage
> > information on Ryzen CPUs (note: voltage and current measurements for
> > Threadripper and EPYC CPUs are known to exist, but register locations
> > are unknown, and values are therefore not reported at this time).
> > 
> > Patch 5/6 removes the maximum temperature from Tdie for Ryzen CPUs.
> > It is inaccurate, misleading, and it just doesn't make sense to report
> > wrong information.
> > 
> > Patch 6/6 adds debugfs files to provide raw thermal and SVI register
> > dumps. This may help in the future to identify additional sensors and/or
> > to fix problems.
> > 
> > With all patches in place, output on Ryzen 3900X CPUs looks as follows
> > (with the system under load).
> > 
> > k10temp-pci-00c3
> > Adapter: PCI adapter
> > Vcore:        +1.39 V
> > Vsoc:         +1.18 V
> > Tdie:         +79.9°C
> > Tctl:         +79.9°C
> > Tccd1:        +61.8°C
> > Tccd2:        +76.5°C
> > Icore:       +46.00 A
> > Isoc:        +12.00 A
> > 
> > The voltage and current information is limited to Ryzen CPUs. Voltage
> > and current reporting on Threadripper and EPYC CPUs is different, and the
> > reported information is either incomplete or wrong. Exclude it for the time
> > being; it can always be added if/when more information becomes available.
> > 
> > Tested with the following Ryzen CPUs:
> >     1300X A user with this CPU in the system reported somewhat unexpected
> >           values for Vcore; it isn't entirely if at all clear why that is
> >           the case. Overall this does not warrant holding up the series.
> >     1600
> >     1800X
> >     2200G
> >     2400G
> >     2700
> >     2700X
> >     2950X
> >     3600X
> >     3800X
> >     3900X
> >     3950X
> >     3970X
> >     EPYC 7302
> >     EPYC 7742
> > 
> > Many thanks to everyone who helped to test this series.
> > 
> > ---
> > v4: Normalize current calculations do show 1A / LSB for core current and
> >     0.25A / LSB for SoC current. The reported current values are board
> >     specific and need to be scaled using the configuration file.
> >     Clarified that the maximum temperature of 70 degrees C (which is no
> >     longer displayed) was associated to Tctl and not to Tdie.
> >     Added debugfs support.
> > 
> > v3: Added more Tested-by: tags
> >     Added detection for 3970X, and report Tccd1 for this CPU.
> > 
> > v2: Added Tested-by: tags as received.
> >     Don't display voltage and current information for Threadripper and EPYC.
> >     Stop displaying the fixed (and wrong) maximum temperature of 70 degrees C
> >     for Tdie on model 17h/18h CPUs.


