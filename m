Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F24C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A065320679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ldm8Vw/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732729AbgCPVnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 17:43:08 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40502 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732672AbgCPVnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 17:43:08 -0400
Received: by mail-ot1-f66.google.com with SMTP id h17so894092otn.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 14:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WMrl/A4S6Os3YKniWIbLiOD8XUx/BAWQkzygslygIP0=;
        b=Ldm8Vw/ml3LDuNk/Sl8EV0aDsuBxJFUDKM0gcQErgV85iZrIM33vtem51He5gs2qbW
         tnwhCYte5Dq+Cz7Gx6Dpyrom3n0/OAMoLdObTgFsuG/uG0cZr8/UhfOglxf2q+8qweMV
         81cLpqcVi0O3tp4RT7JhlwH+xlh7OM9qLgGEltbiRPQVSZgKa2yR21TShplxtRFjFkio
         1N3/cFGWQ86tVjXq3pEkwXQ+6uRvHPpSLFPds/yBf0Zj8+rCihVrILs7qvjN0ebpx1PN
         A33XMEBEMTaVYJrtMYIfGxYypx42XxzS87mJPJTJ55E1aMCpNLd+q5X3lfYAA5CVOL6F
         SSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WMrl/A4S6Os3YKniWIbLiOD8XUx/BAWQkzygslygIP0=;
        b=Fgulu7HIimLO9oERM5UoFUukV+4oTEekbWZQBOe7jqLRoz3ZRGUfCaXBBUAC72elIa
         mQMtrg5FVeJVnnzSHrfpkfHOhFto6X7nmHvNmvBjy/2h49syr3n5wRix70tCF7iesp3y
         Am00bh8j6iy8vC5k5myKt74V51FfBmH/Od9uybrp1cn2dxmAzddn+0O70l0L2a52zavu
         J7PCXJgIVJbDiBQOVVO75cUV0LOhmLNjguTRBn4yuu/WODpqkm396BvPPh2rTUrMkpHZ
         Hdkdf2h/HFoh5BIJ6A48pXlXyz9FwVlRlXYXSap+ox0FEEWvBuHXWZB7jrBtblKNnZxE
         zoFg==
X-Gm-Message-State: ANhLgQ0dE9BP8a3BewWHjvqM+CnallGyzIvNT4xthfCTLBCYmHFapESJ
        RRlt+ZV9RQGsbyKVqczssXG9LTdsj+6rjy6UsffoTw==
X-Google-Smtp-Source: ADFU+vsfOUDl2usOfPoCGuD95oqi+EJZczpkiHeGbcNg5IfGGLn0G3tJWv1OPuc56W4ecmTljIjyHuiVxjSNoRZCgnc=
X-Received: by 2002:a05:6830:c5:: with SMTP id x5mr1098239oto.302.1584394985594;
 Mon, 16 Mar 2020 14:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <1584340511-9870-1-git-send-email-yangpc@wangsu.com> <1584340511-9870-4-git-send-email-yangpc@wangsu.com>
In-Reply-To: <1584340511-9870-4-git-send-email-yangpc@wangsu.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Mon, 16 Mar 2020 17:42:49 -0400
Message-ID: <CADVnQymgwy7+YkLvZ44iq_iO5kFBPqy-Q9hzNEvS=u5p_UBsQQ@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next v2 3/5] tcp: stretch ACK fixes in Veno prep
To:     Pengcheng Yang <yangpc@wangsu.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 2:37 AM Pengcheng Yang <yangpc@wangsu.com> wrote:
>
> No code logic has been changed in this patch.
>
> Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
> ---
>  net/ipv4/tcp_veno.c | 44 +++++++++++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 21 deletions(-)

Indeed this looks like a pure refactor.

Acked-by: Neal Cardwell <ncardwell@google.com>

thanks,
neal
