Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CFDC35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 04:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B59B20578
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 04:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EbGgUBfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgBKEBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 23:01:13 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34910 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbgBKEBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 23:01:13 -0500
Received: by mail-io1-f66.google.com with SMTP id h8so10224759iob.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 20:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4buYt5AgDWSnOLoqzB+NXq6gHo2NLQrY6EneimmcY/I=;
        b=EbGgUBfok7BXKQEyRgMinLqphU/3PooP89wWbd7vhKCl0g7lneRf95+Z9BHqJ2sNUI
         1+sgmoIVjtBNd1K4HhnUvO4vme2Ku/db+TkQXH+BpC9jqtSa8Zl7KC2L4T4qSebA+wze
         6jig6NnzJnpimA+riQaQbTWJSnFMqHnIOLMBPYnZ5Tf+UZMfdBwdFpWI3fOarIL9y08s
         AgL1oljChdQBeN3e6LQHHNqzhvfuoOkcUL++Qj42ndnF9umZ2J9DrNKMAvtC0J4GgK2q
         PtFfH9EydP5T4LBKVl+r5tkDa2hIur/xg9jlZN4v3FU2Ij2lf0/P311eU4zgmxJDsbk2
         4Fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4buYt5AgDWSnOLoqzB+NXq6gHo2NLQrY6EneimmcY/I=;
        b=mlxzNWP9iN5yT5JFsHWTmuOei+0ihvCyCDbZKnI27L+ZY1fYJf4zwwDopIhzAlDUeU
         WjL0Q6/+Z1kA9EIbzBCo+cCbnTCCb7SVkz3wArzBOGKsC8Of5Fi6iwJFGVKe70fXOTN+
         hWNBG/DwnpJ9rppeeSk0hQnrqnnIeM7uMw1nxd+BrVZiOhcO2AiKVOP4bOucLiiRswbF
         HsqhJMFplPylS18pku355VjAn9mHj/uPZFCm6gDaNqUkg7tozM7LIz2dL7FnipC33xlJ
         /2/tJcvJyAHzYx0/iq1U7F11/ubaQAuEFgKtgOHdEUkRddPMHwwmWD00KvK072s6S7So
         iecQ==
X-Gm-Message-State: APjAAAWQSmPQ7DUGGCKnAsJqPkqd/muIID+l/s/eo3vhDB6PQ0BceRWC
        s4UL/oWp81KI92t6NQjM+pDYVSkQUQAAxhHbP7XJ6A==
X-Google-Smtp-Source: APXvYqw+08fY8RTUXanCx7m69NxM7pqghw9BLW/ZXaw5EU7f0BChsUrONvpDowoY6RhmyzszawcD+PzKxe+IyrwkgxA=
X-Received: by 2002:a02:950d:: with SMTP id y13mr12902796jah.139.1581393670761;
 Mon, 10 Feb 2020 20:01:10 -0800 (PST)
MIME-Version: 1.0
References: <1581322611-25695-1-git-send-email-brent.lu@intel.com>
 <00ed82c4-404a-ec70-970e-56ddce9285ae@linux.intel.com> <CAOReqxhHfTuj6mxeX2e_ejMY8N4u+BFLfzKDgn=y5EbWLL_joA@mail.gmail.com>
 <a0aa0705-8d74-3316-13f8-8661d31e928b@linux.intel.com> <CAOReqxiNomQ7OOoE8LHWKH_LkaerSgsO-Yr4918Az2e_50THaA@mail.gmail.com>
In-Reply-To: <CAOReqxiNomQ7OOoE8LHWKH_LkaerSgsO-Yr4918Az2e_50THaA@mail.gmail.com>
From:   Fletcher Woodruff <fletcherw@google.com>
Date:   Tue, 11 Feb 2020 13:00:33 +0900
Message-ID: <CAMSu_6F5N27KY822uL8_ZD7iHDhiBYLrrFfNJe3QXtb9RNyogw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: da7219: check SRM lock in trigger callback
To:     Curtis Malainey <cujomalainey@google.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        Mark Brown <broonie@kernel.org>, Brent Lu <brent.lu@intel.com>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 1:18 AM Curtis Malainey <cujomalainey@google.com> wrote:
>
> +Fletcher Woodruff
> See comment #3 in the bug. This is not a GLK specific issue. If I remember correctly Fletcher found that this was occurring on 2-3 platforms.

Yes, I tested this and saw the same bug on a Pixelbook Go which I
believe is Comet Lake.


>SST has the ability to turn on clocks on demand which is why this has not been an issue previously from what I understand on the bug.
>
> And that is a fair point, we do need to consider other users of the codec.
>
>
> On Mon, Feb 10, 2020 at 8:07 AM Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:
>>
>>
>>
>> On 2/10/20 9:44 AM, Curtis Malainey wrote:
>> > +Jimmy Cheng-Yi Chiang <cychiang@google.com>
>> >
>> > This error is causing pcm_open commands to fail timing requirements,
>> > sometimes taking +500ms to open the PCM as a result. This work around is
>> > required so we can meet the timing requirements. The bug is explained in
>> > detail here https://github.com/thesofproject/sof/issues/2124
>>
>> Ah, thanks for the pointer, but this still does not tell me if it's a
>> GLK-only issue or not. And if yes, there are alternate proposals
>> discussed in that issue #2124, which has been idle since November 25.
>>
>> What I am really worried is side effects on unrelated platforms.
