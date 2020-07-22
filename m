Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35DDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 897D120771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="Yoy1F4D5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgGVTwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 15:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGVTwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:52:42 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41120C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 12:52:41 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j19so1844244pgm.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 12:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=1cGKIJpjawJti4g8SzXEonfEdlP5yq0CvN8z5K3Dldw=;
        b=Yoy1F4D5SdX59+ds7mcQz5JHUDBl4fr7U9s03rPcO/LhScRFnIG9oYi04943Pyg2ap
         QO8rRLplFMiQLcJhq6abEof80+wc3Cq6YgtwLMpVrrfBBOLBgDW9EtB8SRwK7b5TouNo
         FG7RpEdSt3aWO6VpWh5zPY+WHf6SYyc+NMhPEgpsdu+1hdfzb5rqGk7Mk2vGBCpiLMfk
         M2WMXdpC7+mWmSRDiq6A2yI2qfWzI9/2a5PLaIDTVfkIW+UfI26AMELRrElSVaArF2AH
         f+NZ0cHy9P0lcCkdQ8Agh4YYefdHQyxAnmIhKl992R0eGV3Njth6PWUOMpPlFy1YKm3v
         Muug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=1cGKIJpjawJti4g8SzXEonfEdlP5yq0CvN8z5K3Dldw=;
        b=TqPXVUnlrpU4dInPM85SelmrFXRyi2JdRXc4tbejPO1zYo+rIqYujHURIS7b+uKDPW
         aef0Rs1H1e66wkOpVADgOhIMJYiYQnNWbfaey45fbKmDp+oH0r01A7cFLa+ocJPuwjUX
         /XWUK9dKHUnLr5VAJ+D9Bf+fbBYsXTcU2h2VHHp+eTfyQorEEmbgSv8NfX+udT1BoZg5
         1VVloFcvlkb8O+FyFzmg+nQm8zLV967EDbDl4FNGJDH6pJ5bK0BE6p82BDqoZlRggU5x
         0FECCHa7sbghD/caoBDH1FZBiupAXHJLhL7KXGYPI8iqXMPcjczanq0iXBG8sE9HOBtB
         Ij8Q==
X-Gm-Message-State: AOAM532sNbHOdOoGG1w+dnSuZTg0g47GwW/b0+0vfIejlxpNR25G4OQ4
        zWgW/vWu08qvlUIONEpu310jiw==
X-Google-Smtp-Source: ABdhPJzfnsEJ9u3sgDkfEADIkHOoeK603qojzxPEwBQeACIUHuB6n2njWNz3cI4X1mmHVknKJAO4xQ==
X-Received: by 2002:a63:8c4f:: with SMTP id q15mr1206804pgn.373.1595447560352;
        Wed, 22 Jul 2020 12:52:40 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q13sm443560pfk.8.2020.07.22.12.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 12:52:39 -0700 (PDT)
Date:   Wed, 22 Jul 2020 12:52:39 -0700 (PDT)
X-Google-Original-Date: Wed, 22 Jul 2020 12:52:36 PDT (-0700)
Subject:     Re: [PATCH v5 1/4] riscv: Move kernel mapping to vmalloc zone
In-Reply-To: <CAK8P3a34sT2bQbkZUjaxaShzCkn+s35pXxS0UNhqGFu+t2hZYw@mail.gmail.com>
CC:     alex@ghiti.fr, aou@eecs.berkeley.edu, benh@kernel.crashing.org,
        linux-mm@kvack.org, mpe@ellerman.id.au,
        Anup Patel <Anup.Patel@wdc.com>, linux-kernel@vger.kernel.org,
        Atish Patra <Atish.Patra@wdc.com>, paulus@samba.org,
        zong.li@sifive.com, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-820ebe55-b4a3-4ab3-b848-6d3551b43091@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jul 2020 02:43:50 PDT (-0700), Arnd Bergmann wrote:
> On Tue, Jul 21, 2020 at 9:06 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Tue, 21 Jul 2020 11:36:10 PDT (-0700), alex@ghiti.fr wrote:
>> > Let's try to make progress here: I add linux-mm in CC to get feedback on
>> > this patch as it blocks sv48 support too.
>>
>> Sorry for being slow here.  I haven't replied because I hadn't really fleshed
>> out the design yet, but just so everyone's on the same page my problems with
>> this are:
>>
>> * We waste vmalloc space on 32-bit systems, where there isn't a lot of it.
>
> There is actually an ongoing work to make 32-bit Arm kernels move
> vmlinux into the vmalloc space, as part of the move to avoid highmem.
>
> Overall, a 32-bit system would waste about 0.1% of its virtual address space
> by having the kernel be located in both the linear map and the vmalloc area.
> It's not zero, but not that bad either. With the typical split of 3072 MB user,
> 768MB linear and 256MB vmalloc, it's also around 1.5% of the available
> vmalloc area (assuming a 4MB vmlinux in a typical 32-bit kernel), but the
> boundaries can be changed arbitrarily if needed.

OK, I guess maybe it's not so bad.  Our 32-bit defconfig is 10MiB, but I
wouldn't really put much weight behind that number as it's just a 64-bit
defconfig built for 32-bit.  We don't have any 32-bit hardware anyway, so if
this becomes an issue later I guess we can just deal with it then.

> The eventual goal is to have a split of 3840MB for either user or linear map
> plus and 256MB for vmalloc, including the kernel. Switching between linear
> and user has a noticeable runtime overhead, but it relaxes both the limits
> for user memory and lowmem, and it provides a somewhat stronger
> address space isolation.

Ya, I think we decided not to do that, at least for now.  I guess the right
answer there will depend on what 32-bit systems look like, and since we don't
have any I'm inclined to just stick to the fast option.

> Another potential idea would be to completely randomize the physical
> addresses underneath the kernel by using a random permutation of the
> pages in the kernel image. This adds even more overhead (virt_to_phys
> may need to call vmalloc_to_page or similar) and may cause problems
> with DMA into kernel .data across page boundaries,
>
>> * Sort out how to maintain a linear map as the canonical hole moves around
>>   between the VA widths without adding a bunch of overhead to the virt2phys and
>>   friends.  This is probably going to be the trickiest part, but I think if we
>>   just change the page table code to essentially lie about VAs when an sv39
>>   system runs an sv48+sv39 kernel we could make it work -- there'd be some
>>   logical complexity involved, but it would remain fast.
>
> I assume you can't use the trick that x86 has where all kernel addresses
> are at the top of the 64-bit address space and user addresses are at the
> bottom, regardless of the size of the page tables?

They have the load in their mapping functions, as far as I can tell that's
required to do this sort of thing.  We do as well to handle some of the
implicit boot stuff for now, but I was assuming that we'd want to get rid of
that for performance reasons.  That said, maybe it just doesn't matter?  
