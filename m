Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86528C10DCE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 02:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5887D2074B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 02:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuMwZAgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgCNCz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 22:55:56 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39493 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgCNCzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 22:55:55 -0400
Received: by mail-ua1-f65.google.com with SMTP id o16so4416719uap.6;
        Fri, 13 Mar 2020 19:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZEEnUHwkZMDbVRFi/MzyKhwtIiz6HxIBrFlnIEc6RNU=;
        b=AuMwZAgmr4riVDa7wdFl65UGbZ4NPGwVyOmXN9FamQpp38FJc9QWyRpPPgavRHu2YA
         1Riy2UxhQSpuJoAqXp21QWIwIOKf3fZLRrIbPLriSAcEsDvx01Vvg5V+5061ZkL2Eziu
         rHLU71OXdXjYyq+SnVaUP6QExNGIkSyzQfnaQW90jWIe8q69/f/wIiBT8QumQdUg83n9
         3S+h39Ta5gMlW/aFzjnYn6MhUvC6OoQ+Bxbue5zg9u2tl/DEf593ryyuhKw9y3qxZ9QE
         PmST6E8EHpIXTDtXLX5XmFBjhvsK2CjS3Ew3vp0yrvZFzPGRigyQCbNZ8blBE2ZbbUM3
         4x4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZEEnUHwkZMDbVRFi/MzyKhwtIiz6HxIBrFlnIEc6RNU=;
        b=cMNDCulgd64pBT9VY7+p4dsCjjmxbmHuT71zpfK1yoltoJs8SqHpr9YKsnlIb00Is+
         n5+IxJwTbsnJ1KzlmlKNtbIw9Y+kc9jG8MsSS6cLFMqc5bMthn2F0BmLT60TSC8Jckd4
         Pshm/MZUHdkRlcWiEg3bqnAutECcDlvjYiYl3l9TKcTOzoTwM+EQYSwWN1YK3xYvsXL+
         PX/IHnOv/a3KVagGPcGJHS4uEStP0oGkBf5cy+M1MiNrAXyAR6hH/0BfwvM6heo8IIQ+
         sOgA4MsgyKO+u879tgX93z4uHB5wWtE2WFRRhcfSrelNclPDbcdhruBQ3W5GrWvSL0e8
         zGdA==
X-Gm-Message-State: ANhLgQ3jz2TdBrhbx8l/LUPPiAnJCPdIWdjyKkglCWDIGg/ceFyfkp81
        pcVSQOJmPuVMAgv8dH51Ew1MJ1T7VbVaXLMKCRw=
X-Google-Smtp-Source: ADFU+vt5HAY1eZRXXey3qByWkrhH5fVmojXJH1hT5Pi05GrivJuyXkpUc6FauOEuTqrm3ZaccjmCXKrzzSVY8dtb7ZE=
X-Received: by 2002:ab0:2e91:: with SMTP id f17mr6641066uaa.22.1584154554803;
 Fri, 13 Mar 2020 19:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000088452f05a07621d2@google.com> <CADG63jCSHu7dQ118GEuhXBi0H4CW3cBqB5F2qKiyeVzNb0U+wg@mail.gmail.com>
In-Reply-To: <CADG63jCSHu7dQ118GEuhXBi0H4CW3cBqB5F2qKiyeVzNb0U+wg@mail.gmail.com>
From:   Qiujun Huang <anenbupt@gmail.com>
Date:   Sat, 14 Mar 2020 10:55:43 +0800
Message-ID: <CADG63jBWgdO1KpffWqEd3K5iXfK8LcEmv49Fz6Xy_JiS6J9CpA@mail.gmail.com>
Subject: Re: WARNING: refcount bug in sctp_wfree
To:     syzbot <syzbot+cea71eec5d6de256d54d@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com,
        netdev@vger.kernel.org, nhorman@tuxdriver.com,
        syzkaller-bugs@googlegroups.com, vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: https://github.com/hqj/hqjagain_test.git sctp_wfree
