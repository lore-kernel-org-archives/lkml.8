Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318CDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A782253D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gYO0beO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgAVRIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 12:08:50 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44304 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVRIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:08:49 -0500
Received: by mail-qk1-f193.google.com with SMTP id v195so382982qkb.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 09:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Ti+XLiigPGJrnCx1UGw3YWjZIkauoRbqzr6I8agOXYg=;
        b=gYO0beO9qr8Hj+zrQ3WQNAEEYfW6hrtkuOgoZZwbJZa0QMvsQZ9rym+MAb5p5utu4A
         j8O1iPlr0K5ggWcsfoktkcGNdiFMHgGvfZguKeIYhmHWxwOAUmHyIJ1u8VZcg8pSlg52
         mW8Awb7ub6LgQ4Z4lbzjzOScxsSmvsihpJF0uenoMMPrWTXDdowQM2O9nfqGUOtWy9mn
         qaL+QEW82WcLovhCCR71xj2Hd7p1zrWL/y5Hwrj2oWSVCG0K82GQLKC0A2LSO3A/nbnu
         XysoVNRNNdpen0Q9gO72e+sa2xIJNZb0+Gx/ldnR0128BoKlmOciAIEqy2tsauX0jnq0
         GzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Ti+XLiigPGJrnCx1UGw3YWjZIkauoRbqzr6I8agOXYg=;
        b=Yoiz+mXc2bZUEuMgATewi35eY+mJXHNxLiAfPtQZz11txUKZkfI782k8E4wIVVTSSN
         6gWgQ9Ue3EctSjifMflD9irW44PwodJpDgxDv9lX0YdWa3lkuTs8vFn5bUY3onO1CuZS
         9cn7ogXu0qJFzXVSHClwv7m7XZoB7WD5+SW/YVNh6sO8An8ABXzGirPT9iZYbIT7qGkb
         LcAzQ053y5L+M10BXoLLSBwSxhZhdKpUH7KZGmgYOnrR7iGURCYSh88Lo9cJvftun40s
         R7+5lKe+M1Le1JNady+Ty4oMYqOxWwz9u1dQ4aL2oz3voHDoFbZ2SF0ia+4HRE/fIITQ
         uELA==
X-Gm-Message-State: APjAAAUltGhGFDPjQCOc4D+usoB/TKr0Djio+7zZ7FbTmnNr+Ez5SiCF
        rTgMS+2rGXKeiFyBVCTtBCRrsA==
X-Google-Smtp-Source: APXvYqzND5RoFARXrHSbToItbCBzdJPPWIjcuF0uWwO4L/gSnAUDmKtHepOzn0mEsvpWnNo2JgFIIA==
X-Received: by 2002:a05:620a:2010:: with SMTP id c16mr10594941qka.386.1579712928569;
        Wed, 22 Jan 2020 09:08:48 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j15sm2026903qtk.48.2020.01.22.09.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 09:08:47 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] locking/osq_lock: fix a data race in osq_wait_next
Date:   Wed, 22 Jan 2020 12:08:47 -0500
Message-Id: <A5114711-B8DE-48DA-AFD0-62128AC08270@lca.pw>
References: <20200122165938.GA16974@willie-the-truck>
Cc:     mingo@redhat.com, peterz@infradead.org, elver@google.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200122165938.GA16974@willie-the-truck>
To:     Will Deacon <will@kernel.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 22, 2020, at 11:59 AM, Will Deacon <will@kernel.org> wrote:
>=20
> I don't understand this; 'next' is a local variable.
>=20
> Not keen on the onslaught of random "add a READ_ONCE() to shut the
> sanitiser up" patches we're going to get from kcsan :(

My fault. I suspect it is node->next. I=E2=80=99ll do a bit more testing to c=
onfirm.=
