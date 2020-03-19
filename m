Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C0AC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9472072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584637435;
	bh=q1EfazcbGufZH1mTHJ2gw0tS271Cp31RKtV63NA5Nlo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=X3w1VONpdWeiO9sQLm1XPb8VVhtTjoIWMiund9D5v50VFxUPWhiCMi3CXMgERryPe
	 vDfhlKZhnTz9e1tG7ROsK55pKaiM+5zOIz9LfQe5Ut7OEQOj7X3efISirmj/cRT19g
	 9XS4w3iocO+Xd3YIWPYAXhe+LhyYUTw3OIRyqVmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgCSRDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:03:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45035 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgCSRDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:03:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id w4so3309565lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 10:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZlhNoR1NUbr639tPEWnk6rtibaahEXONVk0uSblHyw=;
        b=PdzolwHd8u4BGwOy3TBH+tkDgJJJq29Ku2AY98NX/+LtNupYv23zCu5i/Yf4WhBQlz
         sx+sHPAJjUU2HNotn09AS139ZcD1LRS/qmlfWhz4QHWuPtad3LvhoWwPjMF2CBPnimw8
         y+h9Z6/W3Fgjlx+9J6OmzCyNdEhgwx0Hby3B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZlhNoR1NUbr639tPEWnk6rtibaahEXONVk0uSblHyw=;
        b=nfB+D6Y+4YExEJa8i6cDBnFjaeqY56xH0dlOl9UhWB+aBr1lzGKzOtux+ZwN0si5Hp
         v1n5ojEWQjtXhHUT3F/PzAnWoO7AZL2BtAp90v01iN3WGpHJXETGDQ9Pcdx4F3c9qKKC
         g8NGtg+SZtqihl9ELk4Xa4T0vjcEtp8do0u7dW425qiiHBP6aw/naSsAZhPlAU/LkGfU
         kjiPXJQDfC4LhbuShCLNusNbWpavM0+NxwX+vgiQeNB8rv/1Z7bykumkn3lZNMpKs+0z
         zxxg1e1SV3efhiBNku8C5aLBcdG84BQTzuLgfBBgUztIbmopgqyd7m0wjJrDVQhilGbq
         mnfQ==
X-Gm-Message-State: ANhLgQ21ICovnD9xin4aFDXi8grpVEDY0NycGpgPZkvtYfQEWcy7Yc2y
        F9LCYduqY8we4UVMkmhrisyaoMUuPL4=
X-Google-Smtp-Source: ADFU+vt8pGM0AN+QPbNpeUmJ0/UJYk/8GgBgpiPgH4ufTnPeuxTTi0NhHDNJwe7/2u7bBGOZiwfsmg==
X-Received: by 2002:a2e:8885:: with SMTP id k5mr2795679lji.123.1584637431496;
        Thu, 19 Mar 2020 10:03:51 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id c17sm1550383lff.39.2020.03.19.10.03.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 10:03:50 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id r24so3357602ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 10:03:50 -0700 (PDT)
X-Received: by 2002:a2e:9b07:: with SMTP id u7mr2867061lji.265.1584637430170;
 Thu, 19 Mar 2020 10:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5msOYEYH_YrSwGn6KYW83U0kyNS9U04xLgVFMx4xr32J1Q@mail.gmail.com>
In-Reply-To: <CAH2r5msOYEYH_YrSwGn6KYW83U0kyNS9U04xLgVFMx4xr32J1Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Mar 2020 10:03:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGupJv0ge7epQViXayTmD=SCkqsONsnRNZmEOZ9_3eqg@mail.gmail.com>
Message-ID: <CAHk-=whGupJv0ge7epQViXayTmD=SCkqsONsnRNZmEOZ9_3eqg@mail.gmail.com>
Subject: Re: [GIT PULL] CIFS/SMB3 fixes
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 9:51 PM Steve French <smfrench@gmail.com> wrote:
>
>   git://git.samba.org/sfrench/cifs-2.6.git 5.6-rc6-smb3-fixes

Forgot to push?

   fatal: couldn't find remote ref 5.6-rc6-smb3-fixes

I do see the commit you reference in the "for-linus" branch, but then
I wouldn't get the tag with signature.

Please push it out,

              Linus
