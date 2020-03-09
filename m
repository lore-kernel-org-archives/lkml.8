Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7627C10F28
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 06:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2F820674
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 06:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIOsbo3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgCIGns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 02:43:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42104 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIGns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 02:43:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id f5so4368641pfk.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 23:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vLzrIJTiJKWG/umLvpXl6KYDmMyAdQ96Sz6v66POXZo=;
        b=JIOsbo3oJ4xYG9s8Fr+jNcxbSeSP5nY8gr6LEmZwKl+1229/GElB1DADY0z9ZQYnxw
         D9tjUxq6f5RfNEclWemi5X22nj6/kZR6Qhjs9cTH35ibT5TCbK38kF+EY8RTxyw0RXYc
         Qe1P6wCYCTGIGeDFRSe0XBH1I2CKat+ocEQ6zYTOV9vPEWEUtwe0IV/3lHCusLMgYH1N
         uqdHQPSUUCRj5dxnQlyvOUUVIvXyU0JHPuakCYzOWcYxBJimQril1q8H1lfaIZ6XZlg+
         eU0lyE9iSpH+v6tqIp+F3RNBNQgDYAGRaWa/rLRF3MTZ1c7QIucsyLzIjqEiM8qyWHLp
         w2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vLzrIJTiJKWG/umLvpXl6KYDmMyAdQ96Sz6v66POXZo=;
        b=cLhAxRbk2ZJ5nYv98wNXJEmNBSIDN6WUNnH9tEmJ9qZwOfbDh4E1O/H1LrGraFvIgi
         l9yWmRcASemvBQ2ODxS/B8IwPgjebjLCtnJ0oekiByTIS1mZw5Rmjp4zWRZ1ZqCo5QM5
         Aa9djrfwMItdLWx7V5ccJVS4npyamHccry1JveM1QM+Bu9rIj+cWHPZH4MMowbJzXrNk
         QP2x4/0WY+EpTTkbE27fGoPLGvyGlzKl1v0j+ckQKpkHDlpFpEp/AF8ZC7pLiwLcNdk3
         0cVSVSDbQttInonlR7oiLQb76kW1dNVlAlOeLD6ctvT2/W4K3xmkNWGP0wTr7jVOy4f4
         GACw==
X-Gm-Message-State: ANhLgQ0yHavrUfGOGBmDfCigoIZ7tT8tKuLY9VTbFa80y3s8Ptx6qwA8
        zk35XW0viMa7+sMEHa3ODSQ=
X-Google-Smtp-Source: ADFU+vu5alnH4WMHxnR00roXIgV1wZUcacmBPffsBDeWsRAHzzbVdNLdUE91+PSDWE5JkMsO2ZScGA==
X-Received: by 2002:aa7:92da:: with SMTP id k26mr5983809pfa.139.1583736225415;
        Sun, 08 Mar 2020 23:43:45 -0700 (PDT)
Received: from Shreeya-Patel ([2405:204:2188:9cfe:18bc:a849:c699:3914])
        by smtp.googlemail.com with ESMTPSA id m68sm6869638pjb.0.2020.03.08.23.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Mar 2020 23:43:45 -0700 (PDT)
Message-ID: <af1a27fb8c5f7efbaf99ce3055cf3801b366d627.camel@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] Staging: rtl8188eu: Add space around
 operators
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Joe Perches <joe@perches.com>,
        outreachy-kernel <outreachy-kernel@googlegroups.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, sbrivio@redhat.com,
        daniel.baluta@gmail.com, nramas@linux.microsoft.com,
        hverkuil@xs4all.nl, Larry.Finger@lwfinger.net
Date:   Mon, 09 Mar 2020 12:13:37 +0530
In-Reply-To: <f1327099b774e141bbeaa8abc47f98b9c6d49264.camel@perches.com>
References: <20200308220004.9960-1-shreeya.patel23498@gmail.com>
         <f1327099b774e141bbeaa8abc47f98b9c6d49264.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-03-08 at 16:05 -0700, Joe Perches wrote:
> On Mon, 2020-03-09 at 03:30 +0530, Shreeya Patel wrote:
> > Add space around operators for improving the code
> > readability.
> 
> Hello again Shreeya.
> 
I have some questions here...

> The subject isn't really quite appropriate as you
> are not doing this space around operator addition
> for the entire subsystem.
> 
> IMO, the subject should be:
> 
> [PATCH] staging: rtl8188eu: rtw_mlme: Add spaces around operators
> 
> because you are only performing this change on this
> single file.
> 
> If you were to do this for every single file in the
> subsystem, you could have many individual patches with
> the exact same subject line.
> 
> And it would be good to show in the changelog that you
> have compiled the file pre and post patch without object
> code change.
> 
I'm not sure how to show this. Do you mean to add the output of
"make drivers/staging/rtl8188eu/core" before and after the changes?

I also don't understand the meaning of no object code change. If we are
making the changes to code and then compiling it using the make command
then a new file with .o extension is created and replaced by the
previous one isn't it?  

> Also, it's good to show that git diff -w shows no source
> file changes.
> 

And this has to be...
git diff -w --shortstat drivers/staging/rtl8188eu/core/

Am I correct?

Thanks

> > Reported by checkpatch.pl
> > 
> > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> > ---
> >  drivers/staging/rtl8188eu/core/rtw_mlme.c | 40 +++++++++++------
> > ------
> >  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> When I try this using checkpatch --fix-inplace, I get
> 21 changes against the latest -next tree.
> 
> What tree are you doing this against?
> 
> 

