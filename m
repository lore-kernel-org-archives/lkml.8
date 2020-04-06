Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B44C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5B924A01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586194019;
	bh=BKdCVdBHBzR0xt2+b0w7Ipius4XHObnlB/oBlbzlHWc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jMEYp92cq06bnQLG5QGuqUVuE9IYoUaVbw49s5plzXFk7DTDPoD2gj0ZmISHZB+e5
	 a39BVchj3hKFJg5Hhy8oBS/yZWtktmCVmosWqdN2QOOinz5YNkSq1VpzrI2NeGIe+j
	 kwQguHxZezdTO6yFHvcdCRNACacsTdXD5P10Icwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbgDFR06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:26:58 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34411 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729416AbgDFR06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:26:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id p10so598673ljn.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 10:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZ491r7mDp3NDGymaETOvU1g3XqdwBRrxA5tOEnLogQ=;
        b=TqT24X/roRyAPe/JsynU8OkUqA1rxBWWzcUz5j29g3Du7td4vZHNVUC2hMk5WxnZd7
         c+wZk984zgeiXHuk1D3Kt5ZpxP8uIhsfoiMSa9R8Gp0iWBBs407XpAutonvox1XnKfup
         764yY8jwfyqkWl6S3b1Pd2NMdj7LmkhrBR+b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZ491r7mDp3NDGymaETOvU1g3XqdwBRrxA5tOEnLogQ=;
        b=ijCVkYdeKmVJPNg+FRO5+1UR6DcDQPWb86YnnKvZPnmuejBQ3Zj80ZwwzOjgom36W/
         9BHLVi9+iSJ+A7tJ+JF33XOKmgIH0ExeKq+1AE8XVNPN/HZ2DuJAIMtoDKIafdu6iArh
         TCjArm91V01E9uySS+JsDMwzUMwjCEmRmpZP6UkUrsmmkWPoeCftxCSMQY4u4rA4D2wO
         ksZmNsXyCl+ahkj3hnzrXvw4PHciF6yXqaYxziN/ZFJk+wlepwPnNt/+5kJsksIWSYBk
         ZSPmUTbiJ/CiBsD08FORYvhKeaAYtp16zn+keprjTaUvjI7wCPuwJpSO0VcrpUgtBzX0
         EBCQ==
X-Gm-Message-State: AGi0Puak+jgMLIbVD7+m6klKDS4B7JXe65FYEHMiKTnheFm6bZQ5fyFI
        Ru3WtCGmQh4Nwm0JOQlOTjv3mUfJSSc=
X-Google-Smtp-Source: APiQypKFSwNh53Njn9Qe68sSJCgs62CqHeTdwD9BOLC2Jy0bTib1cCunBfkt81qeoUZ2tIvj/Pjkpg==
X-Received: by 2002:a2e:97c2:: with SMTP id m2mr201378ljj.228.1586194015245;
        Mon, 06 Apr 2020 10:26:55 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id d21sm10378006ljc.49.2020.04.06.10.26.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 10:26:54 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id b1so581912ljp.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 10:26:53 -0700 (PDT)
X-Received: by 2002:a2e:9b8e:: with SMTP id z14mr214337lji.150.1586194013190;
 Mon, 06 Apr 2020 10:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <d509771b7e08fff0d18654b746e413e93ed62fe8.camel@perches.com>
 <a291cce3ff1ba978e7ad231a8e1b7d82f6164e86.camel@perches.com>
 <20200406023700.1367-1-longman@redhat.com> <319765.1586188840@warthog.procyon.org.uk>
 <334933.1586190389@warthog.procyon.org.uk> <dbfcbbd55c63fc87bfb31af3cae1b15e04d8a821.camel@perches.com>
In-Reply-To: <dbfcbbd55c63fc87bfb31af3cae1b15e04d8a821.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Apr 2020 10:26:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPHA4XbL-CVTDBwjYzUJwaGYriGD44uvOaqQai+zOw6A@mail.gmail.com>
Message-ID: <CAHk-=wiPHA4XbL-CVTDBwjYzUJwaGYriGD44uvOaqQai+zOw6A@mail.gmail.com>
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data objects
To:     Joe Perches <joe@perches.com>
Cc:     David Howells <dhowells@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 10:12 AM Joe Perches <joe@perches.com> wrote:
>
> Add yet another alloc flag like __GFP_SENSITIVE
> and have kfree operate on that and not have a
> kfree_sensitive at all.

That sounds potentially sensible. Maybe even a SLAB_SENSITIVE to mark
a whole slab cache sensitive for kmem_cache_create().

I'm not sure how controlled the allocations are, though. The
allocations that get used for keys etc might come from outside the
crypto layer.

                Linus
