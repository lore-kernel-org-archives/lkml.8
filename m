Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D382C2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BC82072F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ehm/OV7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgC0KZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 06:25:57 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49209 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbgC0KZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:25:57 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200327102554euoutp016d26aef51ac6f85c42ed5bc04fe0a034~AIkZ1zQjP2940029400euoutp01X
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 10:25:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200327102554euoutp016d26aef51ac6f85c42ed5bc04fe0a034~AIkZ1zQjP2940029400euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585304754;
        bh=Q7T4AyrE0AJN/v8GqKhjMNo1UHbMdedXuiUU90yqFWY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Ehm/OV7hCtoXv38UlNkzEAwS2s56G6KUhp0fC+fFxIY4G8R+DsSM1m3627LGQuF6f
         inRXxG24N1V+vkZOteo/C9Rgd/4WBUkz+f0GcqedpLL8rrAqOd3+wWQ+vIsJdMxzo9
         AXT6wTW1XmjHyIiEv/xeBnQRSpJOoEtM7P5vBxn8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200327102554eucas1p1001d761387dacfcd0e19f761872b0e60~AIkZkNxw81375613756eucas1p1E;
        Fri, 27 Mar 2020 10:25:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 78.3A.61286.2B4DD7E5; Fri, 27
        Mar 2020 10:25:54 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200327102554eucas1p1f848633a39f8e158472506b84877f98c~AIkZN-Tsz1352813528eucas1p1D;
        Fri, 27 Mar 2020 10:25:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200327102554eusmtrp1a5e09948fd42ecfa61afc7f3b3726a35~AIkZNTw8T1114511145eusmtrp1_;
        Fri, 27 Mar 2020 10:25:54 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-66-5e7dd4b24fbf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 22.4D.07950.2B4DD7E5; Fri, 27
        Mar 2020 10:25:54 +0000 (GMT)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200327102553eusmtip26fe13a9353677c4a19d04ae8aa4aebe4~AIkYlqzJb2542525425eusmtip2E;
        Fri, 27 Mar 2020 10:25:53 +0000 (GMT)
Subject: Re: [RFC PATCH v1] driver core: Set fw_devlink to "permissive"
 behavior by default
To:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <bd8b42d3-a35a-cc8e-0d06-2899416c2996@samsung.com>
Date:   Fri, 27 Mar 2020 11:25:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200321210305.28937-1-saravanak@google.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djP87qbrtTGGSy9JWsx/8g5VouZb/6z
        WTQvXs9msWO7iMXlXXPYLOZ+mcps0br3CLtF16G/bA4cHtt2b2P12DnrLrvHgk2lHptWdbJ5
        7J+7ht3j8ya5ALYoLpuU1JzMstQifbsErox1ZzezFrwSqtjw+Rh7A+ME/i5GTg4JAROJPztb
        mboYuTiEBFYwSszsPsUC4XxhlDiy9wA7hPOZUaL/SDsrTMujo40sILaQwHJGiVs/7SGK3jNK
        rJi4HaxIWCBWYtO+o2DdIgJtjBIP9/0Em8sssIhR4tmSrewgVWwChhJdb7vYQGxeATuJFc8b
        mUFsFgFViU2fVoJNEhWIkbh4uJ8VokZQ4uTMJ2CrOQWsJE4v/QlWzywgL9G8dTaULS5x68l8
        JohT97FL3L0TBGG7SCx418ICYQtLvDq+hR3ClpE4PbkH7DgJgWagS8+tZYdwehglLjfNYISo
        spa4c+4X0KUcQBs0Jdbv0gcxJQQcJb7u14Yw+SRuvBWEOIFPYtK26cwQYV6JjjYhiBlqErOO
        r4PbevDCJeYJjEqzkDw2C8kzs5A8Mwth7QJGllWM4qmlxbnpqcWGeanlesWJucWleel6yfm5
        mxiBSen0v+OfdjB+vZR0iFGAg1GJh1ejpSZOiDWxrLgy9xCjBAezkgjv00igEG9KYmVValF+
        fFFpTmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxSDYxJBh+tQqSdivVmMh47p365
        /ZvbQ+HXAexxGlu3la72m6Bc03Bk11HvT68CNptmmy8Q+bJB1mzS0s1Zp5aoOu18nyHWL8K4
        9Xr2tO/ygdzBLyOVNiyZ6GvcvGvNqjUL3mqe76rY3GbKkbD1lH5c8W2biJ5lk27MmTh3Gr9w
        wVTRuQd89zD8Er6lxFKckWioxVxUnAgAlwLcAUYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xe7qbrtTGGUydxGIx/8g5VouZb/6z
        WTQvXs9msWO7iMXlXXPYLOZ+mcps0br3CLtF16G/bA4cHtt2b2P12DnrLrvHgk2lHptWdbJ5
        7J+7ht3j8ya5ALYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzM
        stQifbsEvYx1ZzezFrwSqtjw+Rh7A+ME/i5GTg4JAROJR0cbWboYuTiEBJYySrx9/owFIiEj
        cXJaAyuELSzx51oXG0TRW0aJ/o3rGEESwgKxEpv2HWUHSYgIdDBKfLt6HayKWWARo8Sse5PA
        qoQELCVmz+piBrHZBAwlut6CjOLk4BWwk1jxvBEsziKgKrHp00qwdaICMRI/93SxQNQISpyc
        +QTM5hSwkji99CdYPbOAmcS8zQ+hbHmJ5q2zoWxxiVtP5jNNYBSahaR9FpKWWUhaZiFpWcDI
        sopRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwErcd+7llB2PXu+BDjAIcjEo8vBotNXFCrIll
        xZW5hxglOJiVRHifRgKFeFMSK6tSi/Lji0pzUosPMZoCPTeRWUo0OR+YJPJK4g1NDc0tLA3N
        jc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTD2F7LtPrnZZfpvxddxZ/9IW8w5MTFi
        3rJ26Rr5Fz593KrLZiy8LeSepH3Q63XUsifTJC3YS2/a91bLBF9eVlhq/+3Htw+X3n1f9yur
        fNfZZY9eliQysOytDv5nc6XHefI044T3YiEPE2N8y350Lnj1yuXjw0nfzO7OdjwZXWzTNOfv
        yjy9g6d1lViKMxINtZiLihMBlVPOA9oCAAA=
X-CMS-MailID: 20200327102554eucas1p1f848633a39f8e158472506b84877f98c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200327102554eucas1p1f848633a39f8e158472506b84877f98c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200327102554eucas1p1f848633a39f8e158472506b84877f98c
References: <20200321210305.28937-1-saravanak@google.com>
        <CGME20200327102554eucas1p1f848633a39f8e158472506b84877f98c@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020-03-21 22:03, Saravana Kannan wrote:
> Set fw_devlink to "permissive" behavior by default so that device links
> are automatically created (with DL_FLAG_SYNC_STATE_ONLY) by scanning the
> firmware.
>
> This ensures suppliers get their sync_state() calls only after all their
> consumers have probed successfully. Without this, suppliers will get
> their sync_state() calls at late_initcall_sync() even if their consuer
>
> Ideally, we'd want to set fw_devlink to "on" or "rpm" by default. But
> that needs more testing as it's known to break some corner case
> drivers/platforms.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Saravana Kannan <saravanak@google.com>

This patch has just landed in linux-next 20200326. Sadly it breaks 
booting of the Raspberry Pi3b and Pi4 boards, either in 32bit or 64bit 
mode. There is no warning nor panic message, just a silent freeze. The 
last message shown on the earlycon is:

[    0.893217] Serial: 8250/16550 driver, 1 ports, IRQ sharing enabled

> ---
>
> I think it's time to soak test this and see if anything fails or if
> anyone complains. Definitely not ready for 5.6. But pulling it in for
> 5.7 and having it go through all the rc testing would be helpful.
>
> I'm sure there'll be reports where some DT properties are ambiguously
> names and is breaking downstream or even some upstream platform. For
> example, a DT property like "nr-gpios" would have a dmesg log about
> parsing error because it looks like a valid "-gpios" DT binding. It'll
> be good to catch those case and fix them.
>
> Also, is there no way to look up current value of early_params? It'd be
> nice if there was a way to do that.
>
> -Saravana
>
>   drivers/base/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 5e3cc1651c78..9fabf9749a06 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2345,7 +2345,7 @@ static int device_private_init(struct device *dev)
>   	return 0;
>   }
>   
> -static u32 fw_devlink_flags;
> +static u32 fw_devlink_flags = DL_FLAG_SYNC_STATE_ONLY;
>   static int __init fw_devlink_setup(char *arg)
>   {
>   	if (!arg)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

