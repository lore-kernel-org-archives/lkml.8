Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234ADC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 22:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89852081E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 22:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="kZT+Dulk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389856AbgAPWJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 17:09:48 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:39647 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732190AbgAPWJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 17:09:47 -0500
Received: by mail-lf1-f44.google.com with SMTP id y1so16770835lfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 14:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ma3+17ZZw0mon2WBoQcLIrloN+FKMVrAslE65nnRmDA=;
        b=kZT+DulkHCqy+z9iJX+SHAKY9BwVQlJATSgdWFeUbn7HaJQDtzziiH3vaLXlz4iKwN
         u5yD1A/ZIU6Q972Sf8Y6Ylc1c+wQ7VMa+EcHijAzmMAuucz9hf7NyhjRkGrV2Rec/hzf
         3UEb/tttT/0v1oxYKXmSzyRqPmzHA0Mdt0O/15NddIbfeEk1mR2FjW5m79XhkbEX/u5I
         2uYn9A6U5G7WrcuLQWORCOIg+rL71/igO6Gp11Rw+CKS6/LZxOFKlWlyGDwtpl4/0sZS
         ymWd+XgIIJ+8XR8U/h0mt1jm74DGkXiSMFHxJ6Q6R+lF02SRPPGkKur13KBVrX+5bCS3
         uYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ma3+17ZZw0mon2WBoQcLIrloN+FKMVrAslE65nnRmDA=;
        b=Noh7RrWy5N7Olzw9DtI/15RHyt/94OuNFMWUynZ12ut7a4tCRjrAfn8bE7UkWPQnnD
         a1+GKY8v2VK3iU/YLDQK0WAhJRqYXHefvtlpIbgkPBM4yMWeFxokBMrLs45hPNxyE1d8
         w8T9oUdhnGEjDR8iG59QStitPZXKHEjdNq4RTtNeDzdf5SGbqgcWVfE/Ue2qOsFeZTXa
         yZ/c1fy/rPfb6m0S2PPT49a8GFJyXoTIOB5rV//NlU8vM0+vt2WOIIxSZWaznNthj8gn
         ewfozf5hBtYtKJv4oKAvNsJ7BZGZAEf5vN7v1OLRLvgwfjJ5Kj9l6L0QsLSYzsd5L/8U
         hoZw==
X-Gm-Message-State: APjAAAWGxt+GGgO2gI6fpn+M3+zlpVR4zB3OsMXSVnpBWn/+9/yu3BVB
        IOXyC0j735yPKjyDubbLqGebg3K//vVo7WOD4EG+9UM=
X-Google-Smtp-Source: APXvYqzMOxzibWcE6CtAi+rGfwOr+6ooiwokDkgIntDt/gMGu/mDs+ST/UaDzUnKHlt/sxNtsDRsfQRolFYXIA/uVs4=
X-Received: by 2002:a19:dc1e:: with SMTP id t30mr3612160lfg.34.1579212585522;
 Thu, 16 Jan 2020 14:09:45 -0800 (PST)
MIME-Version: 1.0
References: <20200117090248.392f40cb@canb.auug.org.au>
In-Reply-To: <20200117090248.392f40cb@canb.auug.org.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Jan 2020 17:09:35 -0500
Message-ID: <CAHC9VhT_mCdJvm-ndx+A=ezBUqKBP1D0WG=9TT2H4pwyspTydQ@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the selinux tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 5:02 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Commit
>
>   6bae00459f0c ("selinux: do not allocate ancillary buffer on first load")
>
> is missing a Signed-off-by from its committer.

My apologies.  Fixed and force pushed to selinux/next.

-- 
paul moore
www.paul-moore.com
