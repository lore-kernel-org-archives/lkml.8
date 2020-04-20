Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DC5C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C0D4206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="b9aWT0Pv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgDTMxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729588AbgDTMw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:52:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BAAC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 05:52:58 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d17so11968932wrg.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 05:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A9w9a9BtCPltYxmsYrcgvCRZHciAh4PTWSTVRz9kigo=;
        b=b9aWT0PvNBisz/4PQKYiKEVpgRsAxhjfLt1qR2nrfXJi3AAsNyH9myAqavnV7G7Wh3
         ElDYT+3Z6mcCFjzJTkesXuFmF6M4ZvyvqDG6Q16cY/iTg381FhpIurr+Vpt8g4fmjHgF
         tLsG2LYWWzRO/EhwTxPLHSjZVHgzASUL7SBZaZtBRdFwdO3yL2HUwXIWoQWvvfg3NMWb
         QInP5qHaC70IjauzS5k9eC6bVnx9AcrwXuwrWMv9E5W977ELACP09TRyluv/MZFu2EWf
         TmcSmHM7Fd4Qyy4Gy/2sXTcK9Y0SPXZ9mXMf9wDgqO65R19TDZFHLQPi/HAb3e0DrdwS
         3jdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A9w9a9BtCPltYxmsYrcgvCRZHciAh4PTWSTVRz9kigo=;
        b=WjNnD8TFQM+5dW+JEcCa3xpgp0q9vZkN0Nh+mUoxVemkwN+a9GrGeFXJRawC8ZY03q
         6TDJHt7x3R3q4y9sh4sEgbzKve4YB16PfQAAtxXJdyBvJ1coNm6VuZVfd8Kig+myFik0
         0LLB7JKRVfr/GbzRq5f+1+2Rb7DEqcLKb/kKs2ZpZOK14ffa2689WyKdGB2n2TwjQOzB
         THcz0WjZBGbKlKajGzywGY+O0FSUKHj7RD5SHjF7Khe31Ulz3Wt0yxKzMJiSS2+TcNxO
         0ifKuHEd7DixHKkhmfUgLvtZ4yt0414Bju2Oeg7D7PJA6k2JOF2aMy+GPcIGb35ONfqI
         M6Hg==
X-Gm-Message-State: AGi0PuZz6QdV8ROmLVw/899WzDPiUa2CeRxPFDyYIChmcjoSBzMSapP0
        mLPBC7oUcTIQhV5gEHdAX2KK+soSC8N+aLF3988Alg==
X-Google-Smtp-Source: APiQypKv8s+5s+Sevqx84IoEmsSamRLTByngbt6QvoW+EFkP1sdpYDQsDL0PBv9J6edYJSBFQPoebLmLgKY71poU3nw=
X-Received: by 2002:a5d:4485:: with SMTP id j5mr17584675wrq.427.1587387177183;
 Mon, 20 Apr 2020 05:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <1587303383-37819-1-git-send-email-ani@anisinha.ca> <20200420090913.GV2586@lahna.fi.intel.com>
In-Reply-To: <20200420090913.GV2586@lahna.fi.intel.com>
From:   Ani Sinha <ani@anisinha.ca>
Date:   Mon, 20 Apr 2020 18:22:46 +0530
Message-ID: <CAARzgwwk+=pRAfhg7bv8Zi8f91m5AMv8gVn9Rwxfgc7-RJ-dxg@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Cleanup unused HP_SUPR_RM macro
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Ani Sinha <ani@anirban.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Denis Efremov <efremov@linux.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 2:39 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Sun, Apr 19, 2020 at 07:06:20PM +0530, Ani Sinha wrote:
> > We do not use PCIE hotplug surprise (PCI_EXP_SLTCAP_HPS) bit anymore.
> > Consequently HP_SUPR_RM() macro is not used in the kernel source anymore.
> > Let's clean it up.
> >
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> BTW, there seem to be other macros like EMI() that is not used anymore
> so maybe worth removing them as well.

Sent a patch.

>
>
> > ---
> >  drivers/pci/hotplug/pciehp.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> > index ae44f46..5747967 100644
> > --- a/drivers/pci/hotplug/pciehp.h
> > +++ b/drivers/pci/hotplug/pciehp.h
> > @@ -148,7 +148,6 @@ struct controller {
> >  #define MRL_SENS(ctrl)               ((ctrl)->slot_cap & PCI_EXP_SLTCAP_MRLSP)
> >  #define ATTN_LED(ctrl)               ((ctrl)->slot_cap & PCI_EXP_SLTCAP_AIP)
> >  #define PWR_LED(ctrl)                ((ctrl)->slot_cap & PCI_EXP_SLTCAP_PIP)
> > -#define HP_SUPR_RM(ctrl)     ((ctrl)->slot_cap & PCI_EXP_SLTCAP_HPS)
> >  #define EMI(ctrl)            ((ctrl)->slot_cap & PCI_EXP_SLTCAP_EIP)
> >  #define NO_CMD_CMPL(ctrl)    ((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
> >  #define PSN(ctrl)            (((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
> > --
> > 2.7.4
