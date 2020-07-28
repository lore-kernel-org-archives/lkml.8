Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB99C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 264DE204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595933973;
	bh=NXsFw2XyW4O0Bp+b0WLr2J2HgG2gKs8jTxH1TJveujQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vxvfh9yRebrFDg28yNcz3wr/iXOlPgax+PjMjdcqDmf3KXi7S//5l0N/kiipwbrbT
	 CsX052QNSZn+Dsy92/sapkBG+4ZGr1yen1RHdkUwVqE5X8W4oCLpIOAJQjhsNAwk4r
	 m9BXMpSfkRtHUeGc276ZVAdoXRpl4hWwWepx4ewk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgG1K7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbgG1K7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:59:31 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286AAC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:59:30 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a21so20165097ejj.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TcHWy1ELrGH7/Ll+zfnmos93UO7CrgTD4KI3mqHtxXA=;
        b=Po0H0vUvDiiD99Qh8zJI2tgXhgLs/QpcMpGnUN2FHkgl1eQGjBdMetm3gCdvsr9c6n
         piW0c7rKDJCGORK25q9YrTac2OXj5QPHjggoNib6ce314q3sX8xJ7O+4kf1uEs8sQvjP
         lGyrCwn1QQ3HLcpXRSgsAufdlyN5BLBHOmOJwdcphgmQgCD7gu3+IbJ1GWFeuObVl3O7
         sDDN+HkyveVe5lmCJHQmXS4KEH/PO+BWZ5rovDzQHBRh8Ca+qmbEteQT+JH9WSKP9ZAE
         FWOhrVlWFNs31hggVq/l15KRvbVoZXkZwwlW47GaS4zEPZpKgZxSPo6FAMOp8FTIZudy
         GGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TcHWy1ELrGH7/Ll+zfnmos93UO7CrgTD4KI3mqHtxXA=;
        b=UeT4JUOpPTi9k4lYWjiG2od7awRvZSJT/E6uW6MNsaIJ/K4jCeUjAhPiShBbykgFuM
         2n5/nClAPkD6Q+GUEdxIYXnvZbqac/7vrCEZHTn0rYzmmcMMCRbVsb1T22w0BFsPeEWi
         hXqNR53Ewk7qFKbrt5/2bAMVnR7xhL1YVS8sPM8neKIzevgOL3k5VR13+AGSnEvdB1Dw
         45U4lMg/1WZXMYXlFoU6SS3w0kQh0sUxbahX/AK8de8eac/WR1ttuurRmnOBu1Ip2jhq
         iIChxFIOU8gv8T+4jAsnCvEZ1efWDg2zWoBCPmKtOqC3O1yn4dOA99bx81L6XCoOQH28
         z6Ig==
X-Gm-Message-State: AOAM531BEJ85SCCL2moT5zVXySi17D993HdOCdlA9TPuNWKnSqc7Fojx
        uHErN1SQ9ro6nzL3iMivqAU=
X-Google-Smtp-Source: ABdhPJzXcHLPNZ8wROo9PTwCJz0JpJi7nDWvXcOpv1HbsszFPgQUF3hU9aCJAfZalhZv7Hh4Ip6/cg==
X-Received: by 2002:a17:906:280c:: with SMTP id r12mr24709100ejc.105.1595933968940;
        Tue, 28 Jul 2020 03:59:28 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id br25sm7784552ejb.25.2020.07.28.03.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 03:59:28 -0700 (PDT)
Date:   Tue, 28 Jul 2020 12:59:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] x86/kaslr: Clean up slot handling
Message-ID: <20200728105926.GD222284@gmail.com>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
 <20200727215047.3341098-8-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727215047.3341098-8-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arvind Sankar <nivedita@alum.mit.edu> wrote:

> The number of slots and slot areas can be unsigned int, since on 64-bit,
> the maximum amount of memory is 2^52, the minimum alignment is 2^21, so
> the slot number cannot be greater than 2^31. The slot areas are limited
> by MAX_SLOT_AREA, currently 100. Replace the type used for slot number,
> which is currently a mix of int and unsigned long, with unsigned int
> consistently.
> 
> Drop unnecessary check that number of slots is not zero in
> store_slot_info, it's guaranteed to be at least 1 by the calculation.
> 
> Drop unnecessary alignment of image_size to CONFIG_PHYSICAL_ALIGN in
> find_random_virt_addr, it cannot change the result: the largest valid
> slot is the largest n that satisfies
> 
>   minimum + n * CONFIG_PHYSICAL_ALIGN + image_size <= KERNEL_IMAGE_SIZE
> 
> (since minimum is already aligned) and so n is equal to
> 
>   (KERNEL_IMAGE_SIZE - minimum - image_size) / CONFIG_PHYSICAL_ALIGN
> 
> even if image_size is not aligned to CONFIG_PHYSICAL_ALIGN.

Please split this up into a couple of easily bisectable patches as 
well:

 - first one harmonizes the integer types used

 - patch that drops the unnecessary check

 - patch that drops the unnecessary alignment operation

Thanks,

	Ingo
