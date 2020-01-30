Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60C1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7882920707
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580400827;
	bh=XYdVW9ANkUk0T3XEk3I4hMN6073rdHrvTiKEoA35b5M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=b03t0CsEjZ9I4n+xONPZAyBzjkKT4QelUC1FGldgvDH2bXOvHkRI3PSapiexZ2n80
	 6/qY88tosCDR637K6BJrNllYPOvqKPS7k4l/Qg1F3p/kv3VO0vhFpx1WSmdzyZ/28C
	 mP0rMmufCoTolJJatrZFtrc02t6jxTjOGYGOJBeE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgA3QNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 11:13:46 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41720 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgA3QNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 11:13:46 -0500
Received: by mail-lf1-f68.google.com with SMTP id m30so2651274lfp.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 08:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4r8XUSGw6ivgjO+/mBvfD4PO+GISzP68HY4vnWOvKeA=;
        b=ToWlwxMRaDVneeA47lRB0wtlnbsjvz/7hQwniurfH9FA93xrfvWSz6c3B2wCVpOGlh
         SIupCkSOSIKU0FfLgTck8zcLJHl8um4mQZSzkaE85F7Cm97ZAY5snhGDFvm5B2AMj5CE
         gJTZAMdlQ0k9Vdk9qe/4begUB//LU0tqv/K/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4r8XUSGw6ivgjO+/mBvfD4PO+GISzP68HY4vnWOvKeA=;
        b=DayAoAakwYf0lan/X6MdVNNA3ADR4vBn4hK1iu8dLoLucULLRV0ndEvMrZ9sdxCCh3
         jnhzyaCmaXvPaBMnppKVjVpePisbklASmoAySDWTkWbyJjRwZQNRkNSoDe+6IjS+0zj2
         tztSnbw2kCcY74b9YrXDqBO3wc+xN0/rfb/w6cHJWrzQyz1/6aSUM5w6P+VXO7ea7W96
         wJRRW0V9P7WKI7Edt7cGQDfuLsJfcfxWibeQz8V4m4CgqMBYtFzAbJtpS6+xtmIcd6zs
         KO4Z/iepMLgPw80OXTgDTg0QCEb7tEq/bDAgRMO73JQ/CdVWzWA9EY9unoWmFQumMIay
         Q+IA==
X-Gm-Message-State: APjAAAWBfmAz9dNNk8KQy9rFTSGgmzwwWf63u7zKRAOVgne0FPl5z3Bx
        uyaSi5f8fia9rnpSXnOtIW9RvQ1g3y0=
X-Google-Smtp-Source: APXvYqyvXsfsQGbl62yTYQLgi2oWXOQ8B3zkCBEHq71Diqovemyk6v7qLyuuZ0d92KsdslAt6ANloQ==
X-Received: by 2002:ac2:46dc:: with SMTP id p28mr2939173lfo.23.1580400823563;
        Thu, 30 Jan 2020 08:13:43 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id i13sm3216312ljg.89.2020.01.30.08.13.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 08:13:42 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id d10so3940697ljl.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 08:13:41 -0800 (PST)
X-Received: by 2002:a2e:909a:: with SMTP id l26mr3079293ljg.209.1580400821584;
 Thu, 30 Jan 2020 08:13:41 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9twBvYvUoijdzAi2=FGLys0pfaK+PZw-uq2kyxqZipeujA@mail.gmail.com>
In-Reply-To: <CAPM=9twBvYvUoijdzAi2=FGLys0pfaK+PZw-uq2kyxqZipeujA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Jan 2020 08:13:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi31OH0Rjv5=0ELTz3ZFUVaARmvq+w-oy+pRpGENd-iEA@mail.gmail.com>
Message-ID: <CAHk-=wi31OH0Rjv5=0ELTz3ZFUVaARmvq+w-oy+pRpGENd-iEA@mail.gmail.com>
Subject: Re: [git pull] drm for 5.6-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 9:58 PM Dave Airlie <airlied@gmail.com> wrote:
>
> It has two known conflicts, one in i915_gem_gtt, where you should juat
> take what's in the pull (it looks messier than it is),

That doesn't seem right. If I do that, I lose the added GEM_BUG_ON()'s.

I think the proper merge resolution does this:

diff --git a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
index f10b2c41571c..f4fec7eb4064 100644
--- a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
+++ b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
@@ -131,6 +131,7 @@ static void gen6_ppgtt_insert_entries(struct
i915_address_space *vm,

        vaddr = kmap_atomic_px(i915_pt_entry(pd, act_pt));
        do {
+               GEM_BUG_ON(iter.sg->length < I915_GTT_PAGE_SIZE);
                vaddr[act_pte] = pte_encode | GEN6_PTE_ADDR_ENCODE(iter.dma);

                iter.dma += I915_GTT_PAGE_SIZE;
diff --git a/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
b/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
index 077b8f7cf6cb..4d1de2d97d5c 100644
--- a/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
+++ b/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
@@ -379,6 +379,7 @@ gen8_ppgtt_insert_pte(struct i915_ppgtt *ppgtt,
        pd = i915_pd_entry(pdp, gen8_pd_index(idx, 2));
        vaddr = kmap_atomic_px(i915_pt_entry(pd, gen8_pd_index(idx, 1)));
        do {
+               GEM_BUG_ON(iter->sg->length < I915_GTT_PAGE_SIZE);
                vaddr[gen8_pd_index(idx, 0)] = pte_encode | iter->dma;

                iter->dma += I915_GTT_PAGE_SIZE;
diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt.c
b/drivers/gpu/drm/i915/gt/intel_ggtt.c
index 79096722ce16..531d501be01f 100644
--- a/drivers/gpu/drm/i915/gt/intel_ggtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_ggtt.c
@@ -787,7 +787,7 @@ static int ggtt_probe_common(struct i915_ggtt
*ggtt, u64 size)
         * readback check when writing GTT PTE entries.
         */
        if (IS_GEN9_LP(i915) || INTEL_GEN(i915) >= 10)
-               ggtt->gsm = ioremap_nocache(phys_addr, size);
+               ggtt->gsm = ioremap(phys_addr, size);
        else
                ggtt->gsm = ioremap_wc(phys_addr, size);
        if (!ggtt->gsm) {

since those ppgtt_insert_entries functions had moved to their
gen-specific files.

No?

            Linus
