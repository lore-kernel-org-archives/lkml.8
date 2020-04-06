Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB9EC2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 01:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2D0206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 01:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMCuX59W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgDFBnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 21:43:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34754 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgDFBnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 21:43:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id l14so6813450pgb.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 18:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=SlwKZhggJtXqNs7Yrk3WMQWVP3iUpdR4maR08x43Blc=;
        b=GMCuX59Wzs8NCxiqc2qUvtMtD+1VUPi9wR9ZGS4RyrTfZ5AVkbpnW/NFGBJaIlSc75
         g/tKe9kLNx98ZcJ2EspzedBVpVQkpoGqols/azIRWBBqFRHI5uSZ+vFT8Vcm1kO/tiCa
         5XflQwEhsGgED444d1iMaRH7WJc3uvC6CEQlqsdP5YpD8FuEfujI2YnWwXGIBDjgaZWP
         G/EBZUo0DolixLtDsW/PbvLjJy5IpALpB0dghhKRtZrwB4I2LbjY2BoTRJcSh+QN9Guj
         lUokaIm6MOZYieb+HprdmtLswu5oSzOO7HswqJpCuxPdsLOSwKEe7v9IFtY1HjwSPDst
         jgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=SlwKZhggJtXqNs7Yrk3WMQWVP3iUpdR4maR08x43Blc=;
        b=S/hlpVcZU0hy/QRPNocJddrnB2jNKxSKtP6LxkZVowW9sdO9ed7DU6ochTMHgfxAYw
         VaY4lF0Wy9w2aTTe8msVBT0W2rT+pTUvIKZcbq/L6/N/836f3iySmPiClqnuzIpEP9Bc
         /Py1FGhqKfwks2sAQVun00S0ozJ0gjuEIp97woLaXceuAkFahiyRanhOf0KTJc/Tr1Z7
         Le7aPKIVc5PJCbmV0i5Zjpj8jU5dtDM1+kbtAR8Qjx3iYToMYylKmLMFZVh7hlOoWk3/
         AjuW2s5tNhDU6xuOc7xYjIbCNd071zf6WHUaeZjSI0nXsltCLhB0Srnad3xoDHF7NJz6
         ySjQ==
X-Gm-Message-State: AGi0Pubi+zfUR+kvR5QbHH+OOMKiKZhs6f/fRUEjoTCd1lz1c2dWsRx+
        swy2AcIc9O4X41Fsm3j3Q5E=
X-Google-Smtp-Source: APiQypK787EqE6ngINs5TXiIV+FU46w5wMuCQfPQ5zgBdP6BwTRdtKCUfE+c/fI77Ac1O+R+BpZnXA==
X-Received: by 2002:a63:f502:: with SMTP id w2mr19256994pgh.423.1586137394697;
        Sun, 05 Apr 2020 18:43:14 -0700 (PDT)
Received: from localhost (60-241-117-97.tpgi.com.au. [60.241.117.97])
        by smtp.gmail.com with ESMTPSA id j96sm10611992pje.32.2020.04.05.18.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 18:43:14 -0700 (PDT)
Date:   Mon, 06 Apr 2020 11:42:06 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH v2 05/13] powerpc/syscall: Rename syscall_64.c into
 syscall.c
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <029e1064b1ad738785718221ea468c9cfc282457.1586108649.git.christophe.leroy@c-s.fr>
        <cacbc62ded444e26e15ca67e0ec91b05b7de6459.1586108649.git.christophe.leroy@c-s.fr>
In-Reply-To: <cacbc62ded444e26e15ca67e0ec91b05b7de6459.1586108649.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1586137301.c2ssus5vmb.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy's on April 6, 2020 3:44 am:
> syscall_64.c will be reused almost as is for PPC32.
>=20
> Rename it syscall.c

Don't mind this, but I wonder if we can rename it to interrupt.c.

A system call is a type of interrupt.

Thanks,
Nick
=
