Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0C4C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 01:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4BE2064A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 01:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585963851;
	bh=ZHilTlRWrt7/y7k+PE66/z8OhJAVkZpJcoHyHt/EHHI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TFKasl05c60bqqbXwPtGxz9BPpraPsBGGOPcGheK5xcCjYKCsuy1zZKflTIW0u3fD
	 gXeRqWqXwT4hQaFXmA8xA9DCuPLJgdCq5juX4yzUS1BzfNgTi1Z/y/Tq011xiMMS6y
	 5sYvCs8+DH+FBObUUhm5QwMjNUZVYPf/SFrjIA3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgDDBau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:30:50 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:36160 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgDDBat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 21:30:49 -0400
Received: by mail-lf1-f52.google.com with SMTP id w145so7333789lff.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 18:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XIe3L/gY2wkFxqTMC8D7UiNGerIlOuEp1J0zlOsiLLs=;
        b=Y71Ig+U4QExnyS/7CIUc/R5xij6o/RpyJxNQ4h0QshkwJRnHu43lOnankUOHOSql+8
         DssvLtPlkjGbxEuIxO07yUcW8HfNHtS+6WXYOqCgYkdxE9BIza9cKfMplUgYsVGti3ey
         hMBPNfpemUWAzUwkh28pQi6b9ZdJi4HV0jrts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XIe3L/gY2wkFxqTMC8D7UiNGerIlOuEp1J0zlOsiLLs=;
        b=cO2HxeSM79Skg5DU8y9EDLwJZoH8fNX5kyCtQvJyRbaoACc0TpfBuOaGXKs1+I2I0m
         Bq+7kNw6DIZbw0adISZUa9gK2nK9HWAVeDCC/lu4AF2r5wg2XGS/mnJA/JcIYjhd9FZr
         PbuuLT5xwTUOUEfUgPpjwYKDGBoaiaxDuJCXWjGzIqrdkG0P5L7ekTS111W7+qG2hcuy
         O40ClBEZnCxCTxc6Od51lnIi94unO5B4VOP8bKWQGc7uFSlGw9XMague4TPcG6t7qayy
         VDKQ0xnaBhMUN1AEW1ahKusN+x41SZR+uqLqlt1FiggtwgeHyOsv+7ES7Gzgq0ZX61fO
         vwUg==
X-Gm-Message-State: AGi0PuZ0SODbGIG9XbtblA8n0sD/vrCWBaM04TH93nQa9oZKJ6CoZV9q
        9QufQcwdY7DT+7THLdciNwO0cq7cXw8=
X-Google-Smtp-Source: APiQypLhuoxgvanZdvLSmB7tCsfhDvDo5HfsTOLP6XuQtYdSSIYxGZ20EyoNhQKp26cbSIrX+wxbPg==
X-Received: by 2002:a19:f518:: with SMTP id j24mr7145925lfb.205.1585963846412;
        Fri, 03 Apr 2020 18:30:46 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id f9sm5910874ljp.88.2020.04.03.18.30.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 18:30:45 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id c5so7348332lfp.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 18:30:45 -0700 (PDT)
X-Received: by 2002:a19:240a:: with SMTP id k10mr7112569lfk.30.1585963844772;
 Fri, 03 Apr 2020 18:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <87blobnq02.fsf@x220.int.ebiederm.org> <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org> <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <328f5ad3-f8b3-09b9-f2f7-b6dae0137542@redhat.com> <CAHk-=wgww8LFqUenUtNV7hzYSxAemjbOVYfZMXqOxK7DGRrZaw@mail.gmail.com>
 <c7c770c9-2c5c-4878-a224-d115720068f3@redhat.com> <86aa9fc6-6ac9-a0c2-3e1d-a602ef16d873@redhat.com>
In-Reply-To: <86aa9fc6-6ac9-a0c2-3e1d-a602ef16d873@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Apr 2020 18:30:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgOykL7cM34NraiNGsjJC5Uq6H0ybYHWhdXDSn-wzVXDQ@mail.gmail.com>
Message-ID: <CAHk-=wgOykL7cM34NraiNGsjJC5Uq6H0ybYHWhdXDSn-wzVXDQ@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Waiman Long <longman@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 4:23 PM Waiman Long <longman@redhat.com> wrote:
>
> Alternatively, we could assert that only one reader can do the upgrade
> and do a WARN_ON_ONCE() if multiple concurrent upgrade attempts is detected.

Ack, that would be best.

[ And since I'm not on mobile any more, and my html email got thrown
out by the list, I'll just repeat that by "static choice" I mean "no
runtime decisions or flags": code that needs the unfair behavior would
use a special unfair function ]

              Linus
