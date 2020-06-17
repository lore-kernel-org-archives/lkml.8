Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDE9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F772073E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592422537;
	bh=kj0CVUWmj6brL8f0EF5vkVooJfxv+yYMAPz+jZjllkU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XXpfaZWW/bV0xF6nMKAhfBywkWBmvca815Dk0myQlJmvvZQ1BDPqJTZXHuE5VSirg
	 zFx1Z7945cbtG8Qt60M5MB+deWistTz0l0lOjNR8qghXLWgHGsvtdkGPaNB8VZ3lRb
	 Grk6npRk3xAvKUIrlz2PMXsD8I8ktDzHgCEX7EDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgFQTfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 15:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgFQTfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 15:35:25 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52EE02073E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 19:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592422524;
        bh=kj0CVUWmj6brL8f0EF5vkVooJfxv+yYMAPz+jZjllkU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=agqnsRa/EK56lzeAqjMVgQ1zbGyGoA2svGW8UU92BMH5riL2IDrqXSl30601Let+T
         Fd8XkVT/VcRME6B1M/dEiFsPsHxNWMLiZjMBzMAVNrUqFSFOmUu+FZ/lEU2FxhFz1O
         X6HuTjdQFU2wcbM7p0A8xL+cYsaejBnp+778vd3I=
Received: by mail-wm1-f54.google.com with SMTP id r9so2990818wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 12:35:24 -0700 (PDT)
X-Gm-Message-State: AOAM530PKd2CKfUwrAC8hBbyCu6PxqMEdeKG7OnKT01XAo/VxHy2yxGt
        kuwilc9Hgp7zn0yvJo17eglgoA2UIhWbsIPYFH+4ag==
X-Google-Smtp-Source: ABdhPJwZufrSC0HSDHfM4LNl3upPjFIP57rAsb579ve9INcvPBLnanr6p4UckI+Bo36Vg5i5NBiwIO759HWAx17PmDw=
X-Received: by 2002:a1c:4804:: with SMTP id v4mr294927wma.21.1592422522886;
 Wed, 17 Jun 2020 12:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <1592418233-17762-1-git-send-email-fenghua.yu@intel.com> <1592418233-17762-2-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1592418233-17762-2-git-send-email-fenghua.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 17 Jun 2020 12:35:11 -0700
X-Gmail-Original-Message-ID: <CALCETrXFHa_05-sGAy5M9YGJWUfTn9MfM-ZYk+hp12tqHNJA0Q@mail.gmail.com>
Message-ID: <CALCETrXFHa_05-sGAy5M9YGJWUfTn9MfM-ZYk+hp12tqHNJA0Q@mail.gmail.com>
Subject: Re: [PATCH v3 01/13] iommu: Change type of pasid to unsigned int
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradeed.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 11:24 AM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> PASID is defined as a few different types in iommu including "int",
> "u32", and "unsigned int". To be consistent and to match with ioasid's
> type, define PASID and its variations (e.g. max PASID) as "unsigned int".
>
> No PASID type change in uapi.

Is PASID in the uapi at all?

--Andy
