Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6548C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 01:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E4120678
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 01:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JODDqlVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgDFB0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 21:26:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37084 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgDFB03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 21:26:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id u65so6779142pfb.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 18:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=bCP/VQw337JNSqQZ2HvUPrrXtQBfFLYo/RggJtgrBzk=;
        b=JODDqlVLar9yt2N3yezSvdVx6Le8p4yT8o0VbdUK272Yp99tZPIZzaU7VSbHlgz0yL
         3pvJOFR1go5wOvBReFKpU2wX/ncT5zVydtd0dsEr+qvR08cN9nq6qNugH5iY3J1aUX4o
         SXPjp37XJg5ZmuLdpa2pNBqPpTNvPaoABnYBYolgC7u15k+Kx6+Y0Se8OWV0MibaywPy
         RCBPhUgaEq//tEPMtOlac9B0LwDaHgnHWx+L7YqwHznNM3NqeFWz7qcuaqLRhymvFCOj
         5fpZMRdo2Z4dUgwafbsw4sWlGKKyJu+9txLNk8xZfUh0nigpUPoZA6MgKATYT8sslUi9
         zC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=bCP/VQw337JNSqQZ2HvUPrrXtQBfFLYo/RggJtgrBzk=;
        b=OTkN2h5WK8Bi4xUkxJ08kk/BXnzXIi54Fee6wsOQHrEuyDR7r+qCMgia1bi2bsidg0
         nQOzBDAFjOISfyFc3Tvz8pJ3NhzWXZ3deFSb3qXBg7rtsXBAIRdHhaEMtPz91V0Rhx1D
         PJZolTMrvzXBeNbSRUpm+j8nFZEXZL13Tv3Sue1VdGVNOLoeoAG7VRkZDJKajftp3sD5
         3ZPFwgwbYydW+TUsxdy66jEgqF6vqZ1AE+LhtfxFOFLbapOS3GKK1kzK9OwBRAvQacCP
         TIcxuiXHpf7pYX14kyJJ/pngbbCoTRgvpRVN6KsyUMIsPZUfROmDbJVyo2Ck4KgFkt4p
         sfEA==
X-Gm-Message-State: AGi0PuYuKc/h+mMBAYr6UCV8dd7i+NeNli0jVzYLoIKHE+K24OKdM5GX
        ufK7K3DUYBy3B6AOWrt0LsQRuK9h
X-Google-Smtp-Source: APiQypKqiMO6ppndjhgdZ6+iwHVyw8jrQA2O3khmT516KEmmVVAwmNYuLrt9v+d/g0JDoWUtctLjpw==
X-Received: by 2002:a65:5647:: with SMTP id m7mr18606743pgs.371.1586136388432;
        Sun, 05 Apr 2020 18:26:28 -0700 (PDT)
Received: from localhost (60-241-117-97.tpgi.com.au. [60.241.117.97])
        by smtp.gmail.com with ESMTPSA id a3sm10322567pfg.172.2020.04.05.18.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 18:26:27 -0700 (PDT)
Date:   Mon, 06 Apr 2020 11:25:20 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH v2 12/13] powerpc/kernel: Do not inconditionally save
 non volatile registers on system call
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <029e1064b1ad738785718221ea468c9cfc282457.1586108649.git.christophe.leroy@c-s.fr>
        <4ef6d617cfd34e09e9bf5a456b2e0b6d2a8a3c96.1586108649.git.christophe.leroy@c-s.fr>
In-Reply-To: <4ef6d617cfd34e09e9bf5a456b2e0b6d2a8a3c96.1586108649.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1586135554.pnqaj0giue.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy's on April 6, 2020 3:44 am:
> Before : 347 cycles on null_syscall
> After  : 327 cycles on null_syscall

The problem I had doing this is that signal delivery wnats full regs,
and you don't know if you have a signal pending ahead of time if you
have interrupts enabled.

I began to try bailing out back to asm to save nvgprs and call again.
I think that can be made to work, but it is more complication in asm,
and I soon found that 64s CPUs don't care about NVGPRs too much so it's
nice to get rid of the !fullregs state.

Possibly another approach would be to leave interrupts disabled for the
case where you have no work to do. You could create a small
syscall_exit_prepare_nowork fastpath for that case for 32-bit, perhaps?

Thanks,
Nick
=
