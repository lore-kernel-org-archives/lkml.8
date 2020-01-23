Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E22C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4899D2253D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579807620;
	bh=gEUhCyf43aFxU6XJ6PNDJqZSC5rtojGWSlON77dK3zA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sLFVu5EKXx/jk/C3419k1Wd8yd6Jgh5z0MH38+rxuCnnxThd742B7qwGiAvNZe1ov
	 Ic4DGuhSvc0BhFb23K/dXpEUXOfQ8lklD40g5QRvVe8NDcYQe1EmZRFD7wJnGI/P9n
	 n05Lhf9YtezaguxHxc9YUhQqN933xsAa+3F19ozI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgAWT07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:26:59 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38365 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgAWT07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:26:59 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so4949346ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 11:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C2UUTxlhM8OOhUZ8uLYw5RDcPKulATuAhzOZCNZ3iAI=;
        b=DQmTS2sD5ZGak4DtLFZbvjA9rCQRhsUY5gHkLATq3NhUv208eViDb4ocXG8du312X/
         6tjxRwwVkl8pT5oSnn5dpbOWT4rJWBlKKov/ZNgF/8nl3MmlsztnaoW/MIYj8DmxCYoL
         1q/DKqnQSmGG1bprtb9ku108u7iQMpkCV0/yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C2UUTxlhM8OOhUZ8uLYw5RDcPKulATuAhzOZCNZ3iAI=;
        b=okGfYGKo0MspJfT27ZOtVLmS9cc2TTAAikL/hv+poxmy4tSpLD0tzF7j9TsR41ynQI
         J+5qQDlQcu3ka0gMwSyN7UGmmqW10Brq9OE6wWn124a83DgM7sYUdpEoYBOBjF/ItaNu
         0ro4CNM7UfzkCMSzHOLdfI4sDSMBeHHiepQABvCPuZs548yzkK1Lw3gKNzkr5D+vyh8S
         AgX6YEDUFB9mMP1Kb8RFiA5zB5EAdGfV44W9e58UeBh4RROYXb914n5D8MNoFCyevEQ3
         Y0qF6WytQuU/83C8uRDovXLFT0S0ZY7umt5yZFqC5dWv5xtivcPsWcuR+/R1uPD91dh5
         NGuA==
X-Gm-Message-State: APjAAAU5NNEwwNYYZtbtB1HgOqR/2nnSpRT+sCH85ZxgOh8rHyMbkft4
        /QOFjiaVeUYOPWIRAahBJb9aqcAuQfI=
X-Google-Smtp-Source: APXvYqy3fqo3YbgDcumciyTB3gqJU2f91lDacQ3PmZDJ1dsa1rpXxR0uioWUikWZbmqjwqpe6a47vA==
X-Received: by 2002:a2e:9716:: with SMTP id r22mr101113lji.224.1579807615568;
        Thu, 23 Jan 2020 11:26:55 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id u13sm1567203lfq.19.2020.01.23.11.26.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 11:26:54 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id q8so4907803ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 11:26:54 -0800 (PST)
X-Received: by 2002:a2e:2a86:: with SMTP id q128mr71515ljq.241.1579807614206;
 Thu, 23 Jan 2020 11:26:54 -0800 (PST)
MIME-Version: 1.0
References: <20200123190456.8E05ADE6@viggo.jf.intel.com>
In-Reply-To: <20200123190456.8E05ADE6@viggo.jf.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Jan 2020 11:26:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgLR5JnaBgCtg0-AAxtdN3=4=LMp6-0212608=vbmCAxg@mail.gmail.com>
Message-ID: <CAHk-=wgLR5JnaBgCtg0-AAxtdN3=4=LMp6-0212608=vbmCAxg@mail.gmail.com>
Subject: Re: [PATCH 0/5] x86: finish the MPX removal process
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Guan Xuetao <gxt@pku.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lovely. Thanks. Patches obviously all look fine.

On Thu, Jan 23, 2020 at 11:23 AM Dave Hansen
<dave.hansen@linux.intel.com> wrote:
>
> I'd _rather_ this go in via the x86 tree, but I'm not picky.  I could also
> send a pull request directly to Linus.

I have no strong feelings either way. I'll happily pull this tree for
the 5.6 merge window directly from you, or get it as part of one of
the x86 -tip pull requests.

Up to you and the -tip maintainers, really. Thomas/Ingo/Borislav?

                 Linus
