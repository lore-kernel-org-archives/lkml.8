Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB5AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64A94207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgHLPnf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:43:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57707 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgHLPne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:43:34 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1k5sua-0001uj-Cr
        for linux-kernel@vger.kernel.org; Wed, 12 Aug 2020 15:43:32 +0000
Received: by mail-pg1-f200.google.com with SMTP id h2so1851790pgc.19
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 08:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bi7NxsjcH5FLItJoaT5RnTY7tEaw2OwMf3N159WZ0VQ=;
        b=G/pu+1/r1VoNd1H6YhrwvY4uRLHShAdvtGOhVeKntFVN4uWRfxUo8YKv232K/w81gr
         KzC7SKIrULX8bCwcZBk4dl8BaCqfsesfUOMKl877tCGML0q57CE8Hep3ZCY1o998gWiI
         gDV0s3O3Z71bdDezeilDGnmJxY6nsCZsUri7OMLLPnAKPL/hslVf928szCBpKM8aiMUn
         B1InXslj0EQVaVqvWa77o6KomvhBFPSURDn5tPymO1qF+HcvFfVsvi4DOc75DtIv9/J6
         FxldcvtG70Bek34GHjA3lvzENe4qWquQ3Zyzw8osTyjo/h+NedKbDnIsFGTeyIx+3Z2a
         S+fQ==
X-Gm-Message-State: AOAM530+yhSUkWEpseoTI7nEV2Xslp8SkOw3HCWV3clRXMbQOYLpihwj
        tMXiq1Bs7SYuSmykssA2NC8JQ2Y0+4OAkhDpd36KLOdQzZ5Mfur9oYpsE8uqsvi/UgkfpwLAehT
        hZsL32AAIEJGUx2D4yUNfJQ7Wk8MqpF1bhliGxHMS1w==
X-Received: by 2002:a17:902:264:: with SMTP id 91mr79130plc.88.1597247010867;
        Wed, 12 Aug 2020 08:43:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzG49h0aM9tFV64seogfDK8Y70jGf7oGrMg4IRq6Jv05oEpnwun9XBdOJCwcOPg9ZrTGy0SBQ==
X-Received: by 2002:a17:902:264:: with SMTP id 91mr79104plc.88.1597247010541;
        Wed, 12 Aug 2020 08:43:30 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id g10sm2972957pfb.82.2020.08.12.08.43.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2020 08:43:29 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] ALSA: hda/hdmi: Use force connectivity quirk on another
 HP desktop
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200811095336.32396-1-kai.heng.feng@canonical.com>
Date:   Wed, 12 Aug 2020 23:43:27 +0800
Cc:     Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Nikhil Mahale <nmahale@nvidia.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Aaron Plattner <aplattner@nvidia.com>,
        Harsha Priya <harshapriya.n@intel.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <44573652-9ECF-4EC5-A234-DBB21FC90CC7@canonical.com>
References: <20200811095336.32396-1-kai.heng.feng@canonical.com>
To:     tiwai@suse.com
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Aug 11, 2020, at 17:53, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> There's another HP desktop has buggy BIOS which flags the Port
> Connectivity bit as no connection.
> 
> Apply force connectivity quirk to enable DP/HDMI audio.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

I guess this patch was omitted as well...

Kai-Heng

> ---
> sound/pci/hda/patch_hdmi.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 4bbd12d3b1b5..b8c8490e568b 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -1863,6 +1863,7 @@ static int hdmi_add_cvt(struct hda_codec *codec, hda_nid_t cvt_nid)
> }
> 
> static const struct snd_pci_quirk force_connect_list[] = {
> +	SND_PCI_QUIRK(0x103c, 0x870f, "HP", 1),
> 	SND_PCI_QUIRK(0x103c, 0x871a, "HP", 1),
> 	{}
> };
> -- 
> 2.17.1
> 

