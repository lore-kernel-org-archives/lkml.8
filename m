Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65F3C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 05:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A39246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 05:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X+LQq/5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgB1FXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 00:23:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44937 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgB1FXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 00:23:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id m16so1467395wrx.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 21:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2bzBaMImUUqw0L+J8P9rtSZngszN+fBGxhpIiKPJlto=;
        b=X+LQq/5dc1+WU7IMxHldrauMIk+LSaWcqEIzBnnvOGwtu4AX/Jo3G+X6SAqG2ohP+U
         qDue0EpDgQyxFA9Y+D15Tnbat/jxDMYUDj05V+b0NvlizGE+9e4sq/xwjzZDMO+JK/aP
         VdqS2/Di9VaYTjQjzfPeQ5+Rvr+zWnH/bYmJ+8dlQwJlISNKXjWXHTem7aTaU3NhKFY4
         Q11HFyXbV1D312U9lLyZUQB/Mc5/x5Bwnc+SsjaZTyPDcEvkKw5TY+qlYbED68s6TQqp
         9KD0mzO9o0Knmpuv28m/3/EGYG9tIfBUvvcwIKYtMaAvqnRrgjF34woBECr6wIlcYmxI
         MMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2bzBaMImUUqw0L+J8P9rtSZngszN+fBGxhpIiKPJlto=;
        b=GtY5PEc2Rv4jOD9VVEoh2Pb+NvANKQXiohHzrdQmOm7b0DoUHp/9Chb14yCnkdeaTD
         wCYDuhnQiMywMyscgpuETc8RBuadu14SZf7Tb9SQDSc+ElhEepZTnk92f4Zt3XQlBnqq
         rOqVrSKPI7WqvWKyHLV71YpzL2iqVlHRiSuORcpjdwrbL4TzYa7eMkSdlpy8Oitj2XWp
         Tuzrs3o0tJheFPYchHtc8cTRNjdIyGvAWY8ZmEhlbVh0caEnnhF+3hkDMWrmLoVoWVjs
         zFI1mjNxUo01SyjKgE5MSPSQvIvJ3DAKLFThf925N5k8Xrjw7pm8Zcnxbx1TOjt4+UQ7
         uEIw==
X-Gm-Message-State: APjAAAV9iZAB/aqgD/Ou2O33foqmy7SV5D6nYXk/ONpgNGJYkKURFHhs
        ld1Iik0K/3tSnca6AdDR4zKnYIHqLOAkyeAHSSuD9Q==
X-Google-Smtp-Source: APXvYqxtQywJ4Y9F6fMaFbR3Xwl/fYlSdJqjBEoT/9MknfP15UA5SIvrBQxjM1D5Jtq9JHmvNLdKKI2nE+J57dZxzMw=
X-Received: by 2002:adf:dfcc:: with SMTP id q12mr2820380wrn.171.1582867420797;
 Thu, 27 Feb 2020 21:23:40 -0800 (PST)
MIME-Version: 1.0
References: <20200228153532.1c0fa33f@canb.auug.org.au>
In-Reply-To: <20200228153532.1c0fa33f@canb.auug.org.au>
From:   Arjun Roy <arjunroy@google.com>
Date:   Thu, 27 Feb 2020 21:23:29 -0800
Message-ID: <CAOFY-A1C_VLqnjr3j6YUTvq_UM+6D8SvoYHJTJ7OYPdgoHTsWQ@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the akpm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 8:35 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the akpm tree, today's linux-next build (sparc defconfig)
> produced this warning:
>
> mm/memory.c:1463:12: warning: 'insert_page_in_batch_locked' defined but not used [-Wunused-function]
>  static int insert_page_in_batch_locked(struct mm_struct *mm, pmd_t *pmd,
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>
Well, that's certainly a step in the right direction if it compiles :)

I guess having this function be within the ifdef is the way to make
this warning go away.

I'll, er, make a v3 patch.

-Arjun

> Introduced by commit
>
>   4a879e02dd49 ("mm/memory.c: add vm_insert_pages()")
>
> --
> Cheers,
> Stephen Rothwell
