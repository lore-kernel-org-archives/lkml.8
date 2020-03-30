Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABDBC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1C22072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbgC3Pia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 11:38:30 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33828 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgC3Pi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 11:38:29 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 05B37296770
Subject: Re: [PATCH v3] platform: x86: Add ACPI driver for ChromeOS
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        vbendeb@chromium.org, andy@infradead.org,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeremy Soller <jeremy@system76.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org
References: <20200330150617.1132570-1-enric.balletbo@collabora.com>
 <20200330153430.GA750889@kroah.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <2ea54a95-213e-41cb-1bf8-bc72475d1f73@collabora.com>
Date:   Mon, 30 Mar 2020 17:38:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200330153430.GA750889@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 30/3/20 17:34, Greg Kroah-Hartman wrote:
> On Mon, Mar 30, 2020 at 05:06:17PM +0200, Enric Balletbo i Serra wrote:
>> This driver attaches to the ChromeOS ACPI device and then exports the values
>> reported by the ACPI in a sysfs directory. These values are not exported
>> via the standard ACPI tables, hence a specific driver is needed to do
>> it. The ACPI values are presented in the string form (numbers as decimal
>> values) or binary blobs, and can be accessed as the contents of the
>> appropriate read only files in the standard ACPI devices sysfs directory tree.
> 
> Any reason why you didn't send this to the ACPI maintainers and
> developer mailing list?
> 

Right, one should never only trust on what get_maintainers returns you. My bad,
I'll cc them. Thanks for pointing it.

Thanks,
 Enric

> They would be the best ones to review this...
> 
> thanks,
> 
> greg k-h
> 
