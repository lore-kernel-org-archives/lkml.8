Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E635DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F28D122B40
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OO+7y7Zo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgHCWLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgHCWLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:11:44 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDD7C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 15:11:44 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b79so36636187qkg.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 15:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uF8luRBGC6gWdncfcHZ2lLN5MmAPsETtk+IqdVjFAwk=;
        b=OO+7y7Zo4t1fTSCcJirSgnVoYMU7it8zYAi8/wDo+lAAFzC5+uk7fN02sYL+VXmf1F
         12e9Wl0UYJyAhjGIXNJZFOiEc2CSIukEK8Tj7fh4f0tllWIy8N3S6cDjj+jZ3jDPGqup
         IyfUBAIyrnj1uWIblUBiFNjTZD96LTF2wucPEtPQd2YG5SxXJD5Vs1CyASZUrGSYiFua
         ylU1R81O+lV/kcEW0DBYf6UVatpklyT6Zzon6JpiNYhzvOzn3O5BkB6/WferNlnz/x8x
         ON0FLm2xACSSv3e3QIqCHEi7w+zAO1cOSwbKfwNjM4kofd6Jf68jcMYQFdc1MqtKLMiW
         /IEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uF8luRBGC6gWdncfcHZ2lLN5MmAPsETtk+IqdVjFAwk=;
        b=LPodMEhaPQ8k4wDdk9qRqHCfg0KqX2I6sUV7UnnAshApIODjlYtknCnW6VRpvgxhFb
         0vShv04ebUGHtHs4Kh7xD3uPQlR+BK8IJBeP/aLBtLiX+MurvRiyeBC3LmA3G3wLnp8w
         leEkMIbedJU32YuprUJ6JiE+nM4/m/5tqRJgus4dJnUykumkznybYJ5Ufq06zFFiUH22
         fBPDtO+QUbGL3+xqoQ1VKXcd5IjIqc6+OiKJVJRgxruEJZgV9n8YqmFtLcvv2VEakH+8
         388kCKklF7KvWyvMNpG77G7OJzWpgNlv6tb2XLcZls85EMlz35u9BnV6L0ZNzIfpHK4E
         +fgA==
X-Gm-Message-State: AOAM533Ht8puVdIGfELNWRtkJASkSCbRLp0pFHq6MFSRVDIY6zBAP/Im
        9C3HjAyxFXTLaoJlE41wgX8ex3heYLjN/+goWMI=
X-Google-Smtp-Source: ABdhPJyWx9iobvP+SxOeDebHgAj8paDE6Bi7DhO525PPiN6DAvHlq5H5qgpz/RIOhikDRhKoPrg0vjGD6mgngNknOjU=
X-Received: by 2002:a37:a44:: with SMTP id 65mr7205489qkk.370.1596492703307;
 Mon, 03 Aug 2020 15:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200601091231.3794350-1-chengzhihao1@huawei.com>
 <CAFLxGvwLSvYsQ+OPi85VS8aQ2uge_JqQRD2C8h=XMORvCej3Sw@mail.gmail.com> <211afcd0-d5b3-5ac0-1fd1-dc789634a858@huawei.com>
In-Reply-To: <211afcd0-d5b3-5ac0-1fd1-dc789634a858@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 4 Aug 2020 00:11:31 +0200
Message-ID: <CAFLxGvwRDfB4mqxJhOLwWvoZ3yzpVY-kuAiovYLf8T7WwJqaTg@mail.gmail.com>
Subject: Re: [PATCH] ubi: check kthread_should_stop() after the setting of
 task state
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "zhangyi (F)" <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 4:01 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
> > Hmm, I see the problem but I fear this patch does not cure the race completely.
> > It just lowers the chance to hit it.
> > What if KTHREAD_SHOULD_STOP is set right after you checked for it?
>
> The patch can handle this case. ubi_thread will exit at
> kthread_should_stop() in next iteration.

How can it reach the next iteration?
Maybe I didn't fully get your explanation.

As far as I understand the problem correctly, the following happens:
1. ubi_thread is running and the program counter is somewhere between
"if (kthread_should_stop())"
and schedule()
2. While detaching kthread_stop() is called
3. Since the program counter in the thread is right before schedule(),
it does not check KTHREAD_SHOULD_STOP
and blindly calls into schedule()
4. The thread goes to sleep and nothing wakes it anymore -> endless wait.

Is this correct so far?

Your solution is putting another check for KTHREAD_SHOULD_STOP before
schedule().
I argue that this will just reduce the chance to hit the race window
because it can still happen
that kthread_stop() is being called right after the second check and
again before schedule().
Then we end up with the same situation.

-- 
Thanks,
//richard
