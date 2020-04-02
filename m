Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C283C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1D820737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585864006;
	bh=5V17bRVVXv8wQGt6nNBm0/LSrVyyN8nRumOQ/rai8K8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XfuiSudshkhCairQPQiW9CD/Tt+9ojxNLIK+8YL9yXRPrmEcNHejTsLU9/KEKdanO
	 fPNe8mu504LkTcX2EFRR8hKdvmlgjfqPNY2yjXvln131YLfayoWrVOyQvfqxQToTBl
	 KjNTCY9xO9pR4948WOvxCeuSwwFbjGAfMcJ1U8pE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389264AbgDBVqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 17:46:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35203 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731783AbgDBVqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 17:46:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id k21so4941290ljh.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 14:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yFmAlnNF/Iq5lTBB0U1MSoGhXNroRuadO5OpNdPUsuM=;
        b=NvTgIm5GUKmHT4HJfYj1GYj7dLz4qHy9Rg6911ad6zzf3yApqWDaWwrtSN80Tqa7wU
         6nag/B567m7T/qv+KzBllJ0HvB09iA2MeO0/PTyeaBAley/IR2ON0Ji0ApW84gL9QbIF
         2eteHd18O7mmtgGunxJLhCRpX4jMtTQxDIlwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yFmAlnNF/Iq5lTBB0U1MSoGhXNroRuadO5OpNdPUsuM=;
        b=UPwU3dLCxxacQI/Yh9MtDFWA8Gs6Ynpgd5ltM66zrC6EhQb47eKc+fKiMAF3RFFbqq
         qPXwtsxty9AlyPz/ghEPoZ9IiSKNRYSHxKpL0EmHB1OkTeRJyfay+mkEZnGvT+MbsL02
         kVgSko6MGbRwvjyCUmxQXryFleeKTfA/nAz262v9IKrsGX+7iY7oa75+Rd+8NpMxP5fX
         VKnkiFuwU3m0LVu1xDRDS3G0YKgTOqQcOCJYUi+qn2Pq+1EZTubw1bw2IY89snvSonox
         2eNpbZt3wh+jSmcwJ5R6kchbFz8O7alcMD1wGZsDtC7FnOW3P2W5SbPCcre22gopI+ea
         HbNg==
X-Gm-Message-State: AGi0PuaAetPB+2YZEbV1oE8re0mDivAdu8l4my7kuy5S62vxqYIJ3/+a
        Vas8Acx9kjbRPAbuWAOE7/zoahfR1a0=
X-Google-Smtp-Source: APiQypLoF/WPoi9y3Ct3/RV31dY7n4qHCY6ZD062ZkV4NBcLKRelIjHzZ3sngx5U4RYwoKPsjwGNjw==
X-Received: by 2002:a2e:a584:: with SMTP id m4mr3236340ljp.194.1585864002100;
        Thu, 02 Apr 2020 14:46:42 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id w29sm5262006lfq.27.2020.04.02.14.46.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 14:46:41 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id f8so2685795lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 14:46:40 -0700 (PDT)
X-Received: by 2002:ac2:5e70:: with SMTP id a16mr3409163lfr.152.1585864000194;
 Thu, 02 Apr 2020 14:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <87blobnq02.fsf@x220.int.ebiederm.org> <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com> <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Apr 2020 14:46:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
Message-ID: <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
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

On Thu, Apr 2, 2020 at 2:00 PM Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
>
> There are two more patches, which might be of interest for you, just to
> make the picture complete.
> It is not clear if we go that way, or if Eric has a yet better idea.
>
> [PATCH v7 15/16] exec: Fix dead-lock in de_thread with ptrace_attach
> https://www.spinics.net/lists/kernel/msg3459067.html

There is no way I would ever take that patch.

The amount of confusion in that patch is not acceptable. Randomly
unlocking the new lock?

That code makes everything worse, it's completely incomprehensible,
the locking rules make no sense ahwt-so-ever.

I'm seriously starting to feel like I should not have pulled this
code, because the future looks _worse_ than what we used to have.

No. No no no. Eric, this is not an acceptable direction.

             Linus
