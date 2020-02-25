Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7798EC35DEC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 00:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3731B20732
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 00:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pdVgPiWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgBYAIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 19:08:17 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42154 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbgBYAIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 19:08:16 -0500
Received: by mail-io1-f65.google.com with SMTP id z1so1161042iom.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 16:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yYLHirngUHxt10qFoU9xmupylPxKXSewlxECiHVcCbc=;
        b=pdVgPiWKRIZ6FGDifzN+jO7VW4qmMUPDK9hEVvS/Uzl7iTkfQxBqNCYbyruzNjkH3R
         FUsq75ZEMBVuEZmMvqJlBUHbo+HQ9+bhK97Nb6Qn8c+k8WLWDt6OcSir14JkDnVim3VL
         dAhGAYEIq3EX7SLhpFZDPFNtOPhCNiVDp+YX66sO+jg2+77959SfeDUcywD9q76Qcb+n
         SXXL7OVxUHg7VJvpXpLbuUq1cGDk5BnhUbJeWXdWWsyTnXEW2RxfLnY6YvR6kf7QgwMi
         G9Ug6sDiaWMxQY/sQIweYBoEk6YUqtOHp1K0Y5poF5WyQOhiz1YMlOp3J8K8ilB1XVBP
         oXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yYLHirngUHxt10qFoU9xmupylPxKXSewlxECiHVcCbc=;
        b=s4/6H7fm8d2lpDxl0v892+jn6aBpMiedGKNHEe8Kf+kPbelNrq/gFSmBe3j0y3Wmib
         uTme+bWl0wQXfzXoR5/xxAWyplRBvqadXkKAR74b3G178pl/A58LVljBg6C27t/RfZMv
         h8JPloxGVUfQoEDU1kOKS8DB7ox8thbRtRD7lLiVHdbqTE+EyKJydl7j1Ii0ec3EbpiE
         xLQ69E2w8yawCpQGQXfBsaZsG4KcNLZJjEmVy0+Whfn4t727K6f9c0tpMkQNhzrMTFnx
         LABDgU5iLX9sXXCEYBcv3GxMCPW0looXAnC8UpT+o0UNAQ12P9ZI/t+KCUIcliTI335y
         erGw==
X-Gm-Message-State: APjAAAU2urfibcY9ppLhPjxfdCtWXhTl/MLwyuFhdYatLRrNljGElKuv
        Hsz+FfO6tIHeQ8sEFUPC0cXHjqNr0xSWutlA/Y9hGg==
X-Google-Smtp-Source: APXvYqxTkakpljUYeVp2JLg4XJzRu6x6qf4LnVcCbcWcEYJgPZZWbcAnu6mgIc2I1Tomu0LoUoG8bchFDT2g5USxwpM=
X-Received: by 2002:a6b:ee01:: with SMTP id i1mr54662261ioh.109.1582589295859;
 Mon, 24 Feb 2020 16:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20200222023413.78202-1-ehankland@google.com> <9adcb973-7b60-71dd-636d-1e451e664c55@redhat.com>
 <0c66eae3-8983-0632-6d39-fd335620b76a@linux.intel.com>
In-Reply-To: <0c66eae3-8983-0632-6d39-fd335620b76a@linux.intel.com>
From:   Eric Hankland <ehankland@google.com>
Date:   Mon, 24 Feb 2020 16:08:04 -0800
Message-ID: <CAOyeoRX8kXD4nHGCLk=pV2EHS4t9wykV5tYDfgKkTLBcN5=GGw@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Adjust counter sample period after a wrmsr
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Like -

Thanks for the feedback - is your recommendation to do the read and
period change at the same time and only take the lock once or is there
another way around this while still handling writes correctly?

Eric
