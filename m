Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6F9C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DECB20674
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Ry8FR1rT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgCLOve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:51:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33470 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgCLOve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:51:34 -0400
Received: by mail-ed1-f65.google.com with SMTP id z65so7812435ede.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ypR/CP4OK72Ocf5cUDOgln51pBdE6rRH8h/xtZQZbe4=;
        b=Ry8FR1rTVGd+/IMLNMA5I544mnkQA+BN5TeMG+FGXLECMChAMxdJvS3dDpb+l0Cm1L
         OuLezQI9aHPYtv/RfD2hlX9n5NycAkeFf3tqAxZWITzpgONCq9C70LjN3ZKXbcLn/UDg
         4K7H4yB5ZB8WwCcwr6yf0pl2SR+ARfFq79LEroMccN1ORei11IaGvj565ukhWTUZOqcu
         4pTf6A209JuHG/sbYXVQk2pkSVOIkoAPQjRxr2GQsSeI9pja4cILgj9sRlZAcAHjnaKW
         USyiFjLIjsWPrElT5OgY+03AkFbKUUOPEIl5kczpRVBCByiik7PCtj/z3t9EMk86O2Fb
         5d6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ypR/CP4OK72Ocf5cUDOgln51pBdE6rRH8h/xtZQZbe4=;
        b=rReDuUbxpAAdvp8lHLUCd5zTrFAKclf2QsCFsjKluoh3rOYeZl+/VxYAL4Lc31vrKq
         fN4rL1gOG+d6p+yNF2n1j/1Aw6oUQ79CdJTG+jfC2S62UmYEm+dQIBS28haN9X4beUn3
         2QOR6lwNphqqD9bwyRo38fH/fjODBkzpHQYM7/dD1HUsOQgoq3S8xRn8izk0hRS0ncIb
         +oXTP2cWy/VstI9u1NWwavWQZrxS4Q7OymqilXRM5Eouh7Epl8fKikQqnYW7UkqZAJZm
         qeQp7fLOJXG18CstHmYzAwgyCtBty1v1sTmwRA2QnIydnSWzk7HPHRN+qq9uDbRVk0AS
         c6Gw==
X-Gm-Message-State: ANhLgQ3Hb/OEomRlGQ8pGITLdyEFZhz0b2LI3U8DkICHHUmd+jPm3lRU
        rlaMci15jc3vDi+L8V1QD9oX1QyiPV25d388v74J
X-Google-Smtp-Source: ADFU+vvUIS5mgc3hdZW3KVgyR0N8eC5HlQrLKiexau837ObSCAf4b7CyefwcQYij+QdMZREevQNeSgyiAg/Quf/Alc8=
X-Received: by 2002:a17:906:3607:: with SMTP id q7mr6940559ejb.308.1584024692633;
 Thu, 12 Mar 2020 07:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <199b556aae531db6e08f2711b1751e976f8bd48a.1583801740.git.rgb@redhat.com>
In-Reply-To: <199b556aae531db6e08f2711b1751e976f8bd48a.1583801740.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Mar 2020 10:51:21 -0400
Message-ID: <CAHC9VhQhO6Srbs=ivb5j2HLmAW1aA+Ju6hpyxUCovT7gm3kJjQ@mail.gmail.com>
Subject: Re: [PATCH V2 ghak120] audit: trigger accompanying records when no
 rules present
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, sgrubb@redhat.com,
        omosnace@redhat.com, Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 9:21 AM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> When there are no audit rules registered, mandatory records (config,
> etc.) are missing their accompanying records (syscall, proctitle, etc.).
>
> This is due to audit context dummy set on syscall entry based on absence
> of rules that signals that no other records are to be printed.
>
> Clear the dummy bit if any record is generated.
>
> The proctitle context and dummy checks are pointless since the
> proctitle record will not be printed if no syscall records are printed.
>
> Please see upstream github issue
> https://github.com/linux-audit/audit-kernel/issues/120
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
> Chagelog:
> v2:
> - unconditionally clear dummy
> - create audit_clear_dummy accessor function
> - remove proctitle context and dummy checks
> ---
>  kernel/audit.c   | 1 +
>  kernel/audit.h   | 8 ++++++++
>  kernel/auditsc.c | 3 ---
>  3 files changed, 9 insertions(+), 3 deletions(-)

Merged into audit/next, thanks.

-- 
paul moore
www.paul-moore.com
