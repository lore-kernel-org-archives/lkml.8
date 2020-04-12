Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8BDC2D0EC
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 20:38:11 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE89206C3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 20:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwCSPG5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE89206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgDLUiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 16:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbgDLUiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 16:38:09 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3E8C0A3BF0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 13:38:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s8so8341479wrt.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 13:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=seG9MaLbjXriUK2S4ve1zQ/t3Xy615mSPre2xaQ8LdU=;
        b=IwCSPG5jmYC4OlDfE0t+c6hcu2PVdfwqynWCXLkL0yR5+C5i01zyNF1PyswsjoeTWg
         6eQnY+7GEAZ01A34Jh9ciwVn254/zf8uXi8v0sJFqipkPiEfNAY2XKdLLDIs/fXBUaNU
         BglCF/sKoKE4G/BWGc/AblxlZjPkih+6CGhVrFnMwd5Bsl53XdBIHqf7qty14gDOM1H/
         jZdAUjwlskfJiIrZasYJjAkJNb+FLXAkddi8y8WaZldgmXc5kPP6i+TRbMLmIumEqARF
         aGXYL8WPPvZZRW0kscFDVkBgaMrCZUCdHJk/gpqRTdPKKtqUsqqdJf3yHeFIKVxFZwWa
         7KUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=seG9MaLbjXriUK2S4ve1zQ/t3Xy615mSPre2xaQ8LdU=;
        b=jFjQRLKRpki067qEjZcR6LPG4GjLXCHHgDP45g8faQ9ZpyQnye0RFfHPT2Jqw2Xtw2
         44mw726Iqaj2gohbBybZpG9R32xv3uSltt1sEt1bFy5ksPLWJrqUmExhJcBgvs3kkEIR
         xzROK6X0aDiharATvtYhlsdnDhsCsk+oYBgukalMwgJJbgcUqRHEenfXxU5IdcE12xm4
         NC5ZYMQICNwdpKLKVUTh0Zff7H4CYkksJg8ozDTJHXo9phmS5luinIK+cY+wedvFj7hA
         RMVlzn6TwxXDApqk9tm9rwMNXpbjF8DeI1h/NGO57zsLTpHYd3MEfvtQBViRA8Ejh/R5
         JYNw==
X-Gm-Message-State: AGi0PuYopOEXMYE3YAUbMAAo4jBNlDIE5opJlF95+xzRihnWt/wSkR5h
        q52JRRkYOPYzRLFmihC7Nb+KUK8I/AnOsv24OVA=
X-Google-Smtp-Source: APiQypJhR1q5eyWTt83zr8lGYJ9LdDDyGgYi2FePqImyyK1EKhc9Bs5B9Y/sBGwQdZA9QG7HQSNcW2QzqbvGE+bUCG8=
X-Received: by 2002:a5d:5745:: with SMTP id q5mr7664737wrw.351.1586723887635;
 Sun, 12 Apr 2020 13:38:07 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 12 Apr 2020 22:37:53 +0200
Message-ID: <CA+icZUXA32mfhYtpucX4tKMeQn-x0AT+8HN9AkPohjhq+OSN3A@mail.gmail.com>
Subject: [Linux 5.7-rc1] Possible boot problems on x86
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Thanks for the 5.7-rc1 release.

Just want to point to the thread "[Bug report] Kernel 5.7 become unbootable".

I have pulled efi.git#tags/efi-urgent into my local Git before
building, testing and booting.

Note: The second patch mentioned in the thread is already included in v5.7-rc1.

d8a26d8fc37c drm/mm: revert "Break long searches in fragmented address spaces"

dileks@iniza:~/src/linux-kernel/linux$ git describe --contains d8a26d8fc37c
v5.7-rc1~23^2~6^2

With my best wishes for a Happy Finnish Easter ceremony/celebration,
- Sedat -

[1] https://marc.info/?t=158645954600003&r=1&w=2
[2] https://lore.kernel.org/linux-efi/20200409130434.6736-1-ardb@kernel.org/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/tag/?h=efi-urgent

P.S.: BTW, it is not social distancing - it is ***physical*** distancing.
