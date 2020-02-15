Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895A6C352A3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 21:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD4E2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 21:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJo4dbZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgBOVNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 16:13:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53235 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgBOVNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 16:13:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so13497970wmc.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2020 13:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=eQWTXpjUDuUW0wmVjEqb5kR2EtspQyyxoUZ3RX5b6yc=;
        b=ZJo4dbZ99IAg/Off3zIJPKiTRvf+JLpHpOpQRge2U8thVSS9RjWFukQNLQ1dx4bOQd
         bp8O6Gba5nu03ZmBiVNZsH9YZKEfJOZ4RRPKJXVrUI6YuiiAbonBXb3uqvupv36ehNSQ
         DDw+4qZnP6uDzqf2YjXDkk44RKjqkDK3TbE+Gq8lJnDRIGFPIRnXhr4hJSHJsFXNWe78
         cInZB9mkAJJRf1yneWx0oKYkVllZyKUCNuniiDYD3cb7wdZhYz11iSxIGvEaK7PcdjDD
         8+M0r4m4SC7AZdoqLqCRSOPFfaKDXbjdZLHBrDaP1atZAkH1MYGnuVre1WEL09KGPMDz
         KZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=eQWTXpjUDuUW0wmVjEqb5kR2EtspQyyxoUZ3RX5b6yc=;
        b=J3bz22igjhsq47sgULljWasBTytKh3QGvWBcBS7mTqvXm1AFi85kZv03Tl2M5ZNDAb
         PWKq7VTxtWQYhcjDg8RGSrapcPp8ffhRu9vfsWcBoCF/95+ZcVnCIZDTGvsAd5XGq4gq
         ZcCIWsxjBSuYcgVDDJ+Hbj7t9BxSxwSUFTa2Qcu+LEbFFWZkTcEd/13X4epSYU7Ep8eD
         AHlL3TSPEFZaIHPRFXS2UPU/GlztjACw7olns0PrOk1P1o8uU9EEpNuwGdiutOzmblKH
         3yMp+3cPfO212hupwGY2RBZdo23l5Sp97J9V0SPU4N6+JoDCFc3KGna5k1veudgtksC+
         LO8Q==
X-Gm-Message-State: APjAAAX4irSaZsEgeGHnM+eWKZhVzOhX2xD/zjyKmmzgz6XorfQWeYy+
        LW/II82KELF/mwQ9Aj5oog==
X-Google-Smtp-Source: APXvYqxm4PPfWmXjjVQmNfjd+0mqu1Kn9niQOa1Z/8jvjYj69Hfz7b7axgKDdFZ+ExJeELaRhmXLCA==
X-Received: by 2002:a1c:ddd6:: with SMTP id u205mr12831995wmg.151.1581801210697;
        Sat, 15 Feb 2020 13:13:30 -0800 (PST)
Received: from ninjahub.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.gmail.com with ESMTPSA id n1sm12846151wrw.52.2020.02.15.13.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 13:13:30 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <maxx@ninjahub.org>
Date:   Sat, 15 Feb 2020 21:13:12 +0000 (GMT)
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
cc:     Jules Irenge <jbi.octave@gmail.com>, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        boqun.feng@gmail.com,
        "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Xen-devel] [PATCH 14/30] x86/xen: Add missing annotation for
 xen_pte_lock()
In-Reply-To: <c4206641-4570-3cbd-1d96-f18aa98e86be@oracle.com>
Message-ID: <alpine.LFD.2.21.2002151601230.31459@ninjahub.org>
References: <0/30> <20200214204741.94112-1-jbi.octave@gmail.com> <20200214204741.94112-15-jbi.octave@gmail.com> <c4206641-4570-3cbd-1d96-f18aa98e86be@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback. I will send the merged version then if it s fine 
with you.
Regards,
Jules

On Fri, 14 Feb 2020, Boris Ostrovsky wrote:

> 
> 
> On 2/14/20 3:47 PM, Jules Irenge wrote:
> > Sparse reports warning at xen_pte_lock()
> >
> > warning: context imbalance in xen_pte_lock() - wrong count at exit
> >
> > The root cause is the missing annotation at xen_pte_lock()
> > Add the missing __acquires(ptl) annotation
> >
> > Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> 
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> 
> although I'd prefer this and the next patch to be merged into a single one.
> 
> 
> 
