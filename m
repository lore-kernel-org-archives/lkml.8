Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C978C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 18:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1778620936
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 18:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592159989;
	bh=6HjV6JeAa3cdwThnpmLRDert6SEydt4zZr5+vshpMfg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=P5N5gn/+hMAX6G7b/fbp7oOV1hfyjurf9bzQOjEz0WFL6n6hEiRrhWO/wGFqrzZf0
	 FGCc94ohohrkPZL+qCmA4e48FwDVLdAaHa3E18+RuPGJJs+FOu4mrToci7bD9cPAeI
	 8LqJzNQZ0lk7shziSraCtGWcqCvuEYpmF4+lNXec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgFNSjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 14:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgFNSjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 14:39:22 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9DFC08C5C2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 11:39:21 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a9so16551081ljn.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 11:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oXvx2kQGekER/HMngBtl5oBpkARJ4k2YYk7QiCC78kk=;
        b=TT1TKZN+de9xCxXLIF7hxeLRHu0iO6joJ4x07Yliuoq91Wxbueu2SpqiSSNKLBBR8y
         spNwn6SAXhYJDUr66RMM33wySXFZK7IQUA3dms6jl5jkbC6ssfy8j/SqYqj0Yloxu1Jq
         8pYf9wOpMD8T4GaeFrOG+HM/WJnCM4BLT59sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oXvx2kQGekER/HMngBtl5oBpkARJ4k2YYk7QiCC78kk=;
        b=GjJM0iICm/uKj53VWaW5btAKQy5kyxJWLqWMPklfGL0+HQ+vwkKOvwe6mz5+PaaK8d
         wjgtTkzW7cegZ+ZpLHZ0mHiKPEoDOnOy5E/UTuvE3YS+imsACqpQ//SzLY3J2Ow6K8Yr
         3QD6KIJQNFe0X645w+8yf5I1Exw250iFQI1yS7rag1eMGEIXHg3ln5aJU7XONB1DG79l
         30Hlto/h8VTaQM6eQ1TFmpdpLfwH+u2uENSVy7deiDyNskRWKY8/yGg4yDRV6gnDvst9
         yk0MFQ4hL84+IgFA2VzjuWGBn19nrwfMQQiedhv7pwZtXgi3FN5w+zYAhqah+14iThXq
         k9sw==
X-Gm-Message-State: AOAM533FtXggpSMbqAXl3KKzMTfFiK3K23tmcelPLntK4sJ5GUAnuPQI
        rQncHjR/WSRGZZWtSO62Brs3iQfmbno=
X-Google-Smtp-Source: ABdhPJzK62pK1u4Y5NC0Xq1Wk5O8iL9scRIqdXpXDu8ZOjHOEN6r5u33bwhwqWIJqpZSReFgBP+eSQ==
X-Received: by 2002:a2e:7c03:: with SMTP id x3mr10650734ljc.227.1592159959610;
        Sun, 14 Jun 2020 11:39:19 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id c8sm4002900lfc.46.2020.06.14.11.39.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2020 11:39:18 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id t74so622217lff.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 11:39:18 -0700 (PDT)
X-Received: by 2002:a05:6512:7b:: with SMTP id i27mr11875869lfo.30.1592159958307;
 Sun, 14 Jun 2020 11:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccOy4qDpbfrP5=KH40LSOx1F4-ciY2=hFv_c+goUHLJ6PQ@mail.gmail.com>
 <CAHk-=wiLXXR1+o4VAuw5MM3V1D8h6C6te3y8VMvW8iAJw6noJg@mail.gmail.com> <CAJ-EccPGQ62yMK1Nmvie4qWzproSqb4POwAD4_0Nt62KLbGhqg@mail.gmail.com>
In-Reply-To: <CAJ-EccPGQ62yMK1Nmvie4qWzproSqb4POwAD4_0Nt62KLbGhqg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Jun 2020 11:39:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZz_E+Bu1L6YTxtDQu_piBjUBoULW7vkKxNux54kwFAA@mail.gmail.com>
Message-ID: <CAHk-=whZz_E+Bu1L6YTxtDQu_piBjUBoULW7vkKxNux54kwFAA@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for v5.8
To:     Micah Morton <mortonm@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 11:04 AM Micah Morton <mortonm@chromium.org> wrote:
>
> I amended the author on the lone commit in this pull request. For some
> reason I was thinking using the "From:" line in the commit body was
> how I should make things show up as Thomas as the author and me as the
> committer, but looks like that=E2=80=99s not true.

That's how we do things in email, since you want a separate author for
the emailed patch than from the author of the email itself.

But git itself very much has that difference between "author" and
"committer" internally, and all the usual email application tools will
take the separate "From:" line from the email, and make that be the
author in git.

(And then the sign-off chain is where we describe the whole path,
because git only has the concept of those two end-points: the original
author, and the final committer, but no concept of the path in between
the two, nor does it have the concept of the copyright and license
agreement implications of the sign-offs).

> I also removed my own Signed-off-by line from the pull request body
> and included it in the commit instead of the Reviewed-by line.

Good. You will get credit for the pull request in the merge commit
itself as a "Pull xyz from Micah Morton", so that path of history gets
encoded that way.

But the sign-off chain is supposed to be there for each individual commit.

(I don't always notice those things, but afaik there is automation in
place in -next that should warn about commits with incomplete sign-off
chains. Did that not trigger for some reason in this case?).

                  Linus
