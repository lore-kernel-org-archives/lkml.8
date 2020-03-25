Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2181C54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 04:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46E02076E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 04:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgCYERY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 00:17:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37010 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCYERY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 00:17:24 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jGxTl-0006Sl-3b
        for linux-kernel@vger.kernel.org; Wed, 25 Mar 2020 04:17:21 +0000
Received: by mail-pf1-f198.google.com with SMTP id h24so1081460pfn.15
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 21:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vVoJdtTocGUlP29HjnLch4GTGfFRHYMMlLvLUSfKJds=;
        b=qU+/jDnpMfa530seUpU/RJyCaoFiUxMvRrfwhsQgN2aYQWDckm9W28Q9kgwdoQFVFF
         gdvwZ+IKeh0SQVu5It9czN/KRvfrZc7TkBjT4lfPPb2rMeVHIvKeIig6FYjyTZ0coo0z
         u3i9QeR0kPCsZlnoohyimDbyc8Oai6zc4mQ7NuDLRzp++TOUpR/KxoeEQPU239Ox4bwF
         gvdgsolxQZncZWyVZz255qDaG29iGGApEtofpqXiv/Q+Ckf9tPo92S5/6gNhdWXG/3Dp
         FWwF3Z59gfVR9rl1jZVvErgdXCQkeZSfqogi4H0FeUDkG6DXbDneT1tds0gSR2axFUA4
         SimA==
X-Gm-Message-State: ANhLgQ0uOnQgHs1YENZeEsbM4TeQOBiem6lohmTrOvb6rtLTM2q6gcZN
        NsWUnxVFFJPq9qJpqs8TDX1D4RhV4DLRFaIBujdA5lokATu+EDO+RFKgl1LHiyGdbn7LW1Yc/am
        98AsVYEZmWRoIyJ0ZpRyDrPkhh6mDIXA5DkTgiKHcgA==
X-Received: by 2002:aa7:947d:: with SMTP id t29mr1294532pfq.184.1585109839583;
        Tue, 24 Mar 2020 21:17:19 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvQpxqBo4YHRa+qrNZnbKcUGaBxApWGqCw9RRRFcwLQK05ook0U0OCinknPd7UlfBZiO4AOKQ==
X-Received: by 2002:aa7:947d:: with SMTP id t29mr1294515pfq.184.1585109839226;
        Tue, 24 Mar 2020 21:17:19 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id q19sm6720989pgn.93.2020.03.24.21.17.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 21:17:18 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] e1000e: bump up timeout to wait when ME un-configure ULP
 mode
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200323191639.48826-1-aaron.ma@canonical.com>
Date:   Wed, 25 Mar 2020 12:17:15 +0800
Cc:     "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        David Miller <davem@davemloft.net>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Neftin, Sasha" <sasha.neftin@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <EC4F7F0B-90F8-4325-B170-84C65D8BBBB8@canonical.com>
References: <20200323191639.48826-1-aaron.ma@canonical.com>
To:     Aaron Ma <aaron.ma@canonical.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

> On Mar 24, 2020, at 03:16, Aaron Ma <aaron.ma@canonical.com> wrote:
> 
> ME takes 2+ seconds to un-configure ULP mode done after resume
> from s2idle on some ThinkPad laptops.
> Without enough wait, reset and re-init will fail with error.

Thanks, this patch solves the issue. We can drop the DMI quirk in favor of this patch.

> 
> Fixes: f15bb6dde738cc8fa0 ("e1000e: Add support for S0ix")
> BugLink: https://bugs.launchpad.net/bugs/1865570
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
> drivers/net/ethernet/intel/e1000e/ich8lan.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index b4135c50e905..147b15a2f8b3 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -1240,9 +1240,9 @@ static s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
> 			ew32(H2ME, mac_reg);
> 		}
> 
> -		/* Poll up to 300msec for ME to clear ULP_CFG_DONE. */
> +		/* Poll up to 2.5sec for ME to clear ULP_CFG_DONE. */
> 		while (er32(FWSM) & E1000_FWSM_ULP_CFG_DONE) {
> -			if (i++ == 30) {
> +			if (i++ == 250) {
> 				ret_val = -E1000_ERR_PHY;
> 				goto out;
> 			}

The return value was not caught by the caller, so the error ends up unnoticed.
Maybe let the caller check the return value of e1000_disable_ulp_lpt_lp()?

Kai-Heng

> -- 
> 2.17.1
> 

