Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E4BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1EFB2083E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824070;
	bh=yNeBVavJCgJ/bhT6Hh3lmuWKw1YLhDe1PyfyvLek4IU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0eURWrY+sYECWnB1KbIAYVUd6X0BRZDiq6eZSa3LrHyXw60AmThuGWsgPO6vBVTm4
	 77LoyXllueFvNyVQu1eLekvNCseMcrrbLC/R2ejVsFlu/YEQB85skvGFql2tFSBcuX
	 mBf+EhsvvHeG1v8X3hDgIUtEuxRs4NQt5TcehEIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbgERRrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730254AbgERRro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:47:44 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1199AC05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 10:47:44 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id e125so8068888lfd.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 10:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ilFS0djlykVy1P5eI7mmIHkWUV2TLGO3S4u/3xid4pg=;
        b=f+uZ9XMvjcg7Pj2CajPFupJFIDSr9ddFhQhrxBb0RA/bsuI7ZzuATo0+/ylZltsOVJ
         R22A7vytwMouhLrIf/3AATPF8b9+0quvf7roPc6/setO6Sv4SVM72UAdlF/UGkInI0XA
         1uTfX87HNlIdTTPW3uw5dFcty9O5kBfWhOOwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ilFS0djlykVy1P5eI7mmIHkWUV2TLGO3S4u/3xid4pg=;
        b=mlsoYA1UGBLZE1nTwKX8a4/KlmbjVa6gfTUWpCZVAKg0cT3CoUHFUl9nECcPmv7oQq
         O9oeeqhr4ZtSEfCRMr9h2qpiVHiggAYRbT8naE+blde0FbBD3CjezSs6qJyxBXhyOlAo
         SOLShwOEhrzfDrMo6H/Rq7xkKo2xI3niBnQ425D303az2C3N9nk5lrIJxmSlErRddt9x
         3VjwanENYt4aHX0/mfhei9twzS4QiqPeXo8rYaLKVzM0O6kN/ojxmz6dPy/rnY9eWrXK
         nF5kona3NqE0VDXQbM7x5bjn1M2EXG59YimaJz6+xBs6JVCPznwTjwux9jSmxAsdKiuH
         WkYw==
X-Gm-Message-State: AOAM532m27Etzq8F2Mn9WsZZ8LgRrWPm6pGvLsq9LNPLKhRqFuqw0cpS
        B+kbmRsWy3H0oO85ftMwkbYsEkqXId4=
X-Google-Smtp-Source: ABdhPJxSp7kLskwBsTm70S8pxaDfwcw5kJh96xNKxi06BGkf4+DDuSsonn2bjPnzRYJDZFfQO3K9XQ==
X-Received: by 2002:ac2:46c1:: with SMTP id p1mr11727121lfo.25.1589824061988;
        Mon, 18 May 2020 10:47:41 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id v28sm1295914lfd.35.2020.05.18.10.47.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 10:47:41 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id v5so8819277lfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 10:47:40 -0700 (PDT)
X-Received: by 2002:a19:d52:: with SMTP id 79mr11576675lfn.125.1589824060570;
 Mon, 18 May 2020 10:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <1589816971.5111.113.camel@linux.ibm.com>
In-Reply-To: <1589816971.5111.113.camel@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 May 2020 10:47:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_Zw7ug+iMALAKfQkdyVAUWC0UB0bfRRPMOCC7U5uTFQ@mail.gmail.com>
Message-ID: <CAHk-=wh_Zw7ug+iMALAKfQkdyVAUWC0UB0bfRRPMOCC7U5uTFQ@mail.gmail.com>
Subject: Re: [GIT PULL] integrity subsystem fixes for v5.7
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 8:49 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity.fixes

No such head.

It looks like the plain 'fixes' branch has the same commit ID, but
there's no next-integrity.fixes.

Btw, any chance you could start using signed tags? I've been
encouraging people to do that even on kernel.org, and we've got fairly
high coverage these days..

             Linus
