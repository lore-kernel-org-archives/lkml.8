Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA12C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 113252166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="MEe5uJV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgEAXR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 19:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbgEAXR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:17:26 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE22C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 16:17:26 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id b1so9240773qtt.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 16:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=jyJyd5oKEahX/i/R9m4SCxwEO1V+hvrK45dVTzQw94s=;
        b=MEe5uJV1EU+C5AMTpYJdXhmqhYt9q9QWSy5lZYkMCHCMCInESMkSVSxVXMEYCOImt7
         vL7ESDahKG033crcJU+dRnzVJdSfXNq34+NpHmTDxAJTV08u9HKbhKLh/GdnpdJ0vGcF
         LZyztMp1VEfaXRIslI5YGG3ruMJbzGo4toUIjvDjayO1wLCKDYHk1PHNMk9LkWLxcrId
         EZgs6cZPVGkZBsIlxItSSqjhYM7/YmjX5w9ZWJYwv5bOxgR7IxxUivNbTBLGFgmipR2L
         YujC8h0nETvtcGgWK+cBN5DBCmQqJXqfM7PQJl9cYTzoYRmGXzpchaKBBmQLqH4LgAjp
         3MqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=jyJyd5oKEahX/i/R9m4SCxwEO1V+hvrK45dVTzQw94s=;
        b=dYHuvsPmZfV5md/sXphFRveOuAxca9OeqhZdaWWm6huzxQ9FKTKX2ECSPELCkRypAA
         uF/llA1aunXV0gkKzP7w1RGT6JhDu0PdX3hhN8m7I1Gw+jFmOEbIFts8ImZMks8RUMZl
         MFVUFDC1/y1yEPmrPqd6FCVgdkHJR/pC82dTCnWyRTN3vnVm2ohtDCOcMCDjERAECcdt
         N/DhdVCfG2GUJ7Egra/aJxVLg7N+UUYAWWCMQ2+Kby+Desu0O4civui2xxVs8ES6JFjn
         Q27a1rCcY6pMSwy1rNcv5KFRaIYSYFm4BzKBb5u/lnmKKwi9c2q2wiq06btn6kDqkDG1
         52mw==
X-Gm-Message-State: AGi0PuZ7xdx7m7GZntxzMb30qx+ZWu66IHZn9t2r2NKwRwe+cqB+Nd89
        dLUR5CuDSv/wLfEQm2OX60NKzA==
X-Google-Smtp-Source: APiQypL+hQnf9nSNBo2V+qE0ckAjwFXYh75FnE39rLv7zEAcP+363kfifDgTlvF9M88uujERkmTN7g==
X-Received: by 2002:ac8:3025:: with SMTP id f34mr6452414qte.219.1588375045649;
        Fri, 01 May 2020 16:17:25 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id c68sm3869073qke.121.2020.05.01.16.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 16:17:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: slub: add panic_on_error to the debug facilities
Date:   Fri, 1 May 2020 19:17:24 -0400
Message-Id: <8CD9EA82-8BE1-47B4-AD35-7D300CAD745C@lca.pw>
References: <20200501215441.GE27720@optiplex-lnx>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@linux.com
In-Reply-To: <20200501215441.GE27720@optiplex-lnx>
To:     Rafael Aquini <aquini@redhat.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 1, 2020, at 5:54 PM, Rafael Aquini <aquini@redhat.com> wrote:
>=20
> It seems like a good idea which also would required "adding things"
> elsewhere, but doesn't look mutually exclusive with the approach here.

Also, what=E2=80=99s so special about these bad pages here that deserve a cr=
ash dump, but not other TAINT_BAD_PAGE places?=
