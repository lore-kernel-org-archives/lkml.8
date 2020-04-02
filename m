Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B4EC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6AA2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585871149;
	bh=Rgoti5syt3fdRTpeLFV/YqOOp6UnRfpNrTF3LLVIP1M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lbTxtOhqCGzvepd0KZ+A/8mr28D7i1uQBFhmlWg3TlPe2238+1m5qClOndd1jjkjW
	 +KkaA0iUns7d+30WpnXFRZV4Cu4TBS9Ciynooi2BAPYNKHLbGbEdMga14iEE23DV1i
	 tLUuWYE+DbD1J330sv8NVFrBhuonBfgQFkPsnImU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390276AbgDBXps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:45:48 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39354 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390219AbgDBXps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:45:48 -0400
Received: by mail-lf1-f66.google.com with SMTP id h6so4253072lfp.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 16:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MXfOpotsLj9yz9nbOTg4sr29DEDaHm+pBs9KhKDhO2c=;
        b=KrPGKHP4VDnO/gg3naRF/HGa7S0RKtlQ2umXBQ3VOLEzXzyemfM0KeL5biR/B/nqRW
         HcIU4NBA3/qKGtGmbQMSFe/ckI07DlhEjL7aeXIYIZsgF3FuGulMTgeXhkFPO4TZk2LN
         VrkNPB9LyVQwGLqalusA8E3iv5CDZRYOtIRxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXfOpotsLj9yz9nbOTg4sr29DEDaHm+pBs9KhKDhO2c=;
        b=UeRsiZhu2oQK0y1OxLVWAn7HEos7M2koWa7MtwTRd7tFXCPtuSQlbEWuCH9LE+BBoX
         7k8z4vXUVgolMd3pP5M9yTuqivFT8hF/OIIEZOVOlPDVCznmAOcT4a9F3WsovxUe3I/+
         VM/iZngJP97MC45x9PwiI7aJ0tlXs/u/Y7qcBRvSCTch0my7eIZJfWsMxCUbjMW2vlyF
         0oBwtPbmy4y40ha7tOuJ8lPZ34y2RRZwi4Ym3+F9u/XNeiDOKoN+tRiwuFCZOaKTfRaL
         6U9bei13asgboiZ7HR+9gl/6BuZK/h4kXN9mvm98yxOdj+eH3goYFM8k1n6yBoF/+QEA
         ideg==
X-Gm-Message-State: AGi0PuYM0e1BNuK2VGLgduhG7VYT3RKc/7LcqCvCy8EKiyur9X6o/xho
        PsrXsX1gbDYqCLvp85ZUiJqzlB4BAvs=
X-Google-Smtp-Source: APiQypKpnxuk29BdXMnp8j0NIoUaI8S26uL+CvX4A73EziwRncJzwq224JYi5ELbsxOHaCIqZlVwKQ==
X-Received: by 2002:ac2:51b3:: with SMTP id f19mr3613235lfk.77.1585871145467;
        Thu, 02 Apr 2020 16:45:45 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id f26sm4033744lja.102.2020.04.02.16.45.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 16:45:44 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id w145so4258705lff.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 16:45:44 -0700 (PDT)
X-Received: by 2002:a19:240a:: with SMTP id k10mr3666029lfk.30.1585871144327;
 Thu, 02 Apr 2020 16:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <87blobnq02.fsf@x220.int.ebiederm.org> <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org> <AM6PR03MB51702497FDBDA78921515562E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB51702497FDBDA78921515562E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Apr 2020 16:45:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVrDiNzh9HY4moub9b8v64O+ST3-eZ2p=OWj7NPj46iQ@mail.gmail.com>
Message-ID: <CAHk-=wiVrDiNzh9HY4moub9b8v64O+ST3-eZ2p=OWj7NPj46iQ@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 4:42 PM Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
>
> Linus that is not the boolean I was talking in the other mail.
> That boolean is called unsafe_execve_in_progres.

Yeah, I tracked what you were trying to say - I did understand how
that patch worked.

I just absolutely and utterly hated it ;/

              Linus
