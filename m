Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E98C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF524206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvhBXdl+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgC3Vb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 17:31:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53625 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbgC3Vb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 17:31:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id b12so403777wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 14:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LIGpKkpwpLZ2Geg9aH+t4dAbGUmN4uvok5TTfT5PwTI=;
        b=DvhBXdl+iyu0EYDDJ0yhX0v65fzLwm4DkFTMcpJbFbjoGvjM0AiBhwsig94ThTnTd6
         f9SM3KSh0ZeqAhC5IBZqA67SJn1TBpkVuOejkpYH4M0EZEtCLAvcAtto8gKpMmXUNKDZ
         Gqlg7dkEBTeK41Q2DI0gDvk6M32DPg0tqqbIHdCJsTlOEXgXaMrdy0CWW3Nz2vlfQQsk
         842rJOxnhceo3AkZWfdMqjF70Ic0/nUyNZePINFipYu76zmdb6EefatyBTuaRh813tTy
         YY4D2r5nwPTYgPUvKOn2T8opED4nFcoLSlTLQHS6m2AO1oxqi4/l+wZ98MeQEEPqvSGW
         hkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LIGpKkpwpLZ2Geg9aH+t4dAbGUmN4uvok5TTfT5PwTI=;
        b=Iz8N4aK8np5tb9eMyo6R8Pgv0hZ7CssQsTFLLfe5f0ueCbuMSQiz3I6vkxlssUMC3X
         FpN4+wfk8uCDx2r12PTLEj9Rk9rjs+Op61c+IOFU9DSINeg5rIvQlA9sjAb5ERogglGF
         vGciHM/CiwSgYSSu+36wGRNR7NXNCRXF5F/KLToRtu1VNVrY7kQ9iSCQ4e1YBTgHUlc4
         BrJWXveOi3BdGqL/1hZirA8DuwzuMgPAqO6rsJkixmWH5LcUltK+nL8pSlDA3NDwSDCY
         Kn7SZhms0K1MQtz+4J99E9z4yHPz/xMyz5HjjGRsIrr6g1a/EI9s8XHxb/G+VGbLJ7HJ
         qJ4w==
X-Gm-Message-State: ANhLgQ35eWGCw6CIFseAE0qiTRLPVpwSrant95agbZw78S+6G/y/u5JD
        1zUBOAlwNBigNf/3q+rRiiY7wKs4TSqp7i0WeLk=
X-Google-Smtp-Source: ADFU+vuizSyENJa4OMAkuycV5Ytjy9Xu98MOogA3NxEMy7IWD55ocS/T1r3oMjK8ZiFcLM1nJsh/crrhb9EM6aVkGoY=
X-Received: by 2002:a05:600c:257:: with SMTP id 23mr66565wmj.155.1585603884358;
 Mon, 30 Mar 2020 14:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200116153607.11910-1-fishland@aliyun.com>
In-Reply-To: <20200116153607.11910-1-fishland@aliyun.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 30 Mar 2020 23:31:12 +0200
Message-ID: <CAFLxGvzbjTTaoquNb6jZTpSRXYV5=XfAfxg7Be6Cfyqsw+-Gig@mail.gmail.com>
Subject: Re: [PATCH] ubifs: Fix out-of-bounds memory access caused by abnormal
 value of node_len
To:     Liu Song <fishland@aliyun.com>
Cc:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, liu.song11@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 4:37 PM Liu Song <fishland@aliyun.com> wrote:
>
> From: Liu Song <liu.song11@zte.com.cn>
>
> In =E2=80=9Cubifs_check_node=E2=80=9D, when the value of "node_len" is ab=
normal,
> the code will goto label of "out_len" for execution. Then, in the
> following "ubifs_dump_node", if inode type is "UBIFS_DATA_NODE",
> in "print_hex_dump", an out-of-bounds access may occur due to the
> wrong "ch->len".
>
> Therefore, when the value of "node_len" is abnormal, data length
> should to be adjusted to a reasonable safe range. At this time,
> structured data is not credible, so dump the corrupted data directly
> for analysis.
>
> Signed-off-by: Liu Song <liu.song11@zte.com.cn>

Applied, thanks!

--=20
Thanks,
//richard
