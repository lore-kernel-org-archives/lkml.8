Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245B9C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E552073E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DVQr77xZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgCXQCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:02:23 -0400
Received: from mail-qv1-f74.google.com ([209.85.219.74]:45942 "EHLO
        mail-qv1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgCXQCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:02:22 -0400
Received: by mail-qv1-f74.google.com with SMTP id d7so16114902qvq.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=0x/hnTcc2kjPvpKyUGqSSPPjkXWDC7wDxqwKdBvhNVI=;
        b=DVQr77xZHndYQNTyk9eR1wUxut89ZPRTqVR/uvTz+HhIZCxy2cl1QRd3lxFpcc9t4N
         XEOKB0oxsLBC5WWTCPJrmChFYD/L12HY4ihcpc3GM0u0VIlQirixO0xoLNJbiA20DYEN
         nWOy6ozI+fywZNiwjeAhhiKfuB1dJFarDFA9/QsOxK3IBkce6IX+W1XFANV4XQggvYCD
         mQPL+8FB4o1iMFLsHfeP9oUuPf9qLLy3YltBPowYTxO7KylXg+5jTaYq3aexZ4VKpVD9
         ur5mMc6Zn7RTVsCizZcVl7T8RoUK/Duh8Y2AvZZVUsYF/vGQlSqZEXXFNshEzsxyPikR
         lCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=0x/hnTcc2kjPvpKyUGqSSPPjkXWDC7wDxqwKdBvhNVI=;
        b=h0zWs4g8MucHUscEdQIpRSI4KtHd1LqpK7XkSDwJGLv0fwjjJK8khhGDaw0ihFRF+u
         2plY3qsfM7V00xp02om7Ae7PV/inOibJkLxigm/xiAtg7T2asJ/bQRZnUwwZ/dcRdR+i
         q9AR8MutwsYSGo7C5aTWzvgR8XH/Mn6fxGmUuuvdydR61j+vpuDs4xRFnXwBmjnQHvao
         yUoT3MI9X3m0S04wayx+GjWOhDyUL5wTro8k77pic/apFHXd3qXZdBfJEBhdex34g9l5
         AvO0YLrSBnEzBgFaIb7Vvvf/XxdK252BoqmeI3CfI4GC9Wypuh9CkQACcKdV3UT0tuzq
         PCeg==
X-Gm-Message-State: ANhLgQ3iCkxitYgx4IzDo+xXuFasjmG5SHAJDuJaJfmBPwOBKLcRxPDR
        3flLdbyckGWTB9G2JSJns5VhZ5fBGXrd
X-Google-Smtp-Source: ADFU+vt4nUw+kxEpkgVNrjtxIzP/E5x6J5Fp51tqyY49tAR6Jz1SAq64BXWbIZPWzdOz/ANvIwAu0IDIwkvC
X-Received: by 2002:ac8:39a1:: with SMTP id v30mr27685736qte.112.1585065741247;
 Tue, 24 Mar 2020 09:02:21 -0700 (PDT)
Date:   Tue, 24 Mar 2020 17:02:02 +0100
In-Reply-To: <20200323114207.222412-1-courbet@google.com>
Message-Id: <20200324160203.99593-1-courbet@google.com>
Mime-Version: 1.0
References: <20200323114207.222412-1-courbet@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH]     x86: Alias memset to __builtin_memset.
From:   Clement Courbet <courbet@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Clement Courbet <courbet@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This shows the kernel getting smaller not larger.
> Is this still reversed or is this correct?

Yes, sorry. This was wrong. The kernel actully shrinks. Fixed.


