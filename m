Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BODY_SINGLE_WORD,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17149C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE91720736
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaPk5yrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgEHH1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 03:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgEHH1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 03:27:54 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0B1C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 00:27:54 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x77so515352pfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 00:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=ziMFDmcizVw/HKzX4CFbEQ+0h/nCHY1FKPAaX8g6rfw=;
        b=YaPk5yrHNDraP9ZIw+kkhXeGAgHIT9QI8OmOVFhz6eiTxsz5iYjKD8IUofzcIpmouQ
         PeXSTaqcpk5w78gg3RxHyWX6RBPVyHHxJCSP0pzua4HLYeGpjdRxx8JoItfTL8dxG1Nq
         /c001rHRBk3j/2ClYXYtX2pFttdRGXBa0bS9wJbNKhu2mgbaA7/bmYvljuJ+kl1/ClrK
         xh1cdwQVUz5SF8eg+PJKYWRI33TGUO89Mx0pFjNvCwLzF4yWPTTGxwYN/7iQQf4JRTRc
         TdgsZNzKlh6Ubjw9GDjz23r5Ci+qcgNtN9ERJTWhMZURKoMGab02Nddta1pnoIvnROEd
         fT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=ziMFDmcizVw/HKzX4CFbEQ+0h/nCHY1FKPAaX8g6rfw=;
        b=KYJxtrpfgqI2BZn8BWneDaIZBdgBRdu7N7eKdRLncU+6NsXXE9HHg2cYLuPXBjt6V+
         NOivuaw2d2u8t+4cLoV1Xg/34SRpeV6sDE0yxN6i38zKbpaSxW69BqlFo20d9o/H0jdj
         GABBjFoCzFMkHo0wDdhraL3Otxm12NDdXbXfEl256V1vP0ykm1aJLlrg2DDt7RfGMm/z
         obd4GWNufWdb/b1cKzQe/Ag6ruPtUr7suUAUzFL9mJzRMDB6h+BP0WD1mDJhXNTK4+Qp
         RX9GPtYhfC01Gt533QNZfretxuzfl6BvQZfrYXC70jQBZtxIL/+J3Tzm1ya2a+Zdgjug
         schA==
X-Gm-Message-State: AGi0PuY7Wgg8+wvsdg7SL/8hccibcUGxpXqGUGqvxHeFL16rotC6Pwh0
        gXSrCkB3jxBOgkjaaVvxEKQ=
X-Google-Smtp-Source: APiQypIGvEOrK5TBOgciriKVMqJIv9YXMO2lGn9oNcebd3rvEJLvHVySW5mfInEgZudUTJej5ayRjw==
X-Received: by 2002:a62:3584:: with SMTP id c126mr1458611pfa.316.1588922873720;
        Fri, 08 May 2020 00:27:53 -0700 (PDT)
Received: from [192.168.86.27] (c-73-222-199-61.hsd1.ca.comcast.net. [73.222.199.61])
        by smtp.gmail.com with ESMTPSA id w1sm753323pgh.53.2020.05.08.00.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 00:27:52 -0700 (PDT)
Date:   Fri, 08 May 2020 00:27:45 -0700
From:   Hill Ma <maahiuzeon@gmail.com>
Subject: Re: [PATCH] x86/reboot/quirks: Add MacBook6,1 reboot quirk
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Message-Id: <9Q40AQ.AIBOX7WP0C792@gmail.com>
In-Reply-To: <20200425200641.GA1554@cslab.localdomain>
References: <20200425200641.GA1554@cslab.localdomain>
X-Mailer: geary/3.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?



