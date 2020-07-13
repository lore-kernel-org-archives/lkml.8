Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DDBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8EE92075D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lh9vyhfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgGMHLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgGMHLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:11:48 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A95C061794;
        Mon, 13 Jul 2020 00:11:48 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id t27so10257907ill.9;
        Mon, 13 Jul 2020 00:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=2mnaiTo0qGcxFq6+IdGd44zv8ruDj4yCsqDxq42cVIE=;
        b=lh9vyhfD/gQLtRklaoZwaMnc+pg6vafrhhSbbdJrlmaWEQwxaM6368jQOyDsJ53a7S
         iXsU+1M5MIXR0V6FAo+PlYFqSiYjjSQlIw36K02f50JuJu6BbCRy/qB9rdIj7wLX+y5O
         b9qiX75PQoPcFi0D3Vwkyi9FZLTWFakkrF24fMpsyhswPPiCj2TA+1+Ds2GxKn0nXU2z
         OpNbpDBIPj0zN3UlBFJRuyTAafXzTZ7Jb0yEUkwCJhQLZCII+RL/gurTUfx/jw+C+jrP
         lh40S1YlckFMR+uQvp0oq7HaHPLrl7jWGyWce/YXbZOJE1gLrjOgIJW61ymBzPhz+nW8
         i0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=2mnaiTo0qGcxFq6+IdGd44zv8ruDj4yCsqDxq42cVIE=;
        b=RBJ8pFROCH2wNC7ADpasVsZOX9BnJbibN7Sfg+yk28Rox9QoNvq/F81z201dxRos1U
         OgBoSaySQ4vjoU4bQw8DUtrXCNi1hvzjQeRwyxp/+54DCYTftpOfQsWamaHETFXBdO9z
         SgxHl0JKwCIfB8710mLAyZK7naW8JBhr5vySC1wjBOC6MNnPx9CUuuvIcnooF+U62JJa
         0itFBIBwRFyoj+svmJO4OytWLTYS8CU3sDmZqmJEqY2eYxDU/VVSCgmvapYIWgXf1Vyz
         NScJh/IdXJ0cwT64aPuAjZhbKTvUETryUfzYLhVT4zy6jnX6bqGUp1L0CNc6SFmyK0a+
         OjgA==
X-Gm-Message-State: AOAM533TArFTC6pa45BNrBwVc8drO6aPfsdIqALSUQr39BcPcZ/imnVH
        tvee0iUECMJR1aXVTmSRweQxx1PmQhEGMCr3xgnmPCR3W0Y=
X-Google-Smtp-Source: ABdhPJzM4AQOKnlqaA6HZcec9ptnZzQHqqGvZCkaM4HYxAtDxf4PS4f+0Tj/jzdwNy8KC1VDj83DjesLV+jaEheyXRw=
X-Received: by 2002:a92:dc4a:: with SMTP id x10mr64252865ilq.111.1594624307565;
 Mon, 13 Jul 2020 00:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsPPoeja2WxWQ7yhX+3EF1gtCHfjdFjx1CwuAyJcSVzz1g@mail.gmail.com>
In-Reply-To: <CABXGCsPPoeja2WxWQ7yhX+3EF1gtCHfjdFjx1CwuAyJcSVzz1g@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 13 Jul 2020 12:11:36 +0500
Message-ID: <CABXGCsP3ytiGTt4bepZp2A=rzZzOKbMv62dXpe26f57OCYPnvQ@mail.gmail.com>
Subject: Re: [5.8RC4][bugreport]WARNING: CPU: 28 PID: 211236 at
 fs/fuse/file.c:1684 tree_insert+0xaf/0xc0 [fuse]
To:     linux-fsdevel@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        mpatlasov@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 at 03:28, Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hi folks.
> While testing 5.8 RCs I founded that kernel log flooded by the message
> "WARNING: CPU: 28 PID: 211236 at fs/fuse/file.c:1684 tree
> insert+0xaf/0xc0 [fuse]" when I start podman container.
> In kernel 5.7 not has such a problem.

Maxim, I suppose you leave `WARN_ON(!wpa->ia.ap.num_pages);` for debug purpose?
Now this line is often called when I start the container.

--
Best Regards,
Mike Gavrilov.
