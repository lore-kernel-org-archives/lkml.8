Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D814C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E265220769
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LhxWNog6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgDIRcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:32:24 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40774 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgDIRcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:32:23 -0400
Received: by mail-yb1-f193.google.com with SMTP id a5so6126380ybo.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 10:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mp9ron0QEbR+5PIC/6wd8mlHTQ3C2lOlQANEcm1kIPk=;
        b=LhxWNog6VVrgOvZOd6G3ZQJUpCHiuIk6yxEutecouJO6tGdNTsHulwM91owTqIFmwP
         EaLc+m4veWreX5at+Shm1YjJCHjf/9mO1338i0wUmlRtT2+UE6KywrnJx0THLhVzE+Ql
         LVaMQbvPW0YZAQe6YZGOfc/qV97n6E4QTclaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mp9ron0QEbR+5PIC/6wd8mlHTQ3C2lOlQANEcm1kIPk=;
        b=aR0W5kL4NCXT7xNmKpE/isAO10zxrESgxw7+S9VFRGjgh94NJIt/n6muc8NkPfBwCg
         9mr01JN9BmsQdhbk19dvRelx8BIWxT1hv6gdFQ+02Vrn+fe9059AaY4+tu5dGBuFMveX
         2SicevFGB/g4d3Y5v0RRcg3wAahK6ZwJD+e/kuinBgt6Zi7lqpIGylsF0QB3ln7XQDqT
         qQisrW+LFEO9TtmRIUefls5vJm+xQ2HDQOklFocjKNvWFMn2mmV3/tyqkqh63y2Bg+AF
         hwOf+DlTuRrDmAIv14YSjLgfn99jymtrNS22C+b0Oplv1/3v0Wfpf/JXaRkiSjxz6Tms
         1mHA==
X-Gm-Message-State: AGi0PuZFuUDkEHO6qcivdEQUJAPv/p82U/U9YzbnlMKvrNer2A2cx2oM
        XsDRd9P7s0xAvSLUHNO6S/pU8Vl1F8hHphWt3jB4LtgGiqk=
X-Google-Smtp-Source: APiQypKnHP7JJ/UOIb1NWR+NfOlMqkd3p1ZIQezrHa0Qko3rdv4wDaUQCokFL88/t/g7xBGI58BoGwPTa3THk2T+axA=
X-Received: by 2002:ab0:3154:: with SMTP id e20mr160174uam.136.1586453077481;
 Thu, 09 Apr 2020 10:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200304010650.259961-1-abhishekpandit@chromium.org> <20200409170742.27865-1-youling257@gmail.com>
In-Reply-To: <20200409170742.27865-1-youling257@gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Thu, 9 Apr 2020 10:24:25 -0700
Message-ID: <CANFp7mV_bTKwMPt44BpvkuUtnYz5yh2qhzprbgwhDaqwR8duvw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/5] Bluetooth: Handle system suspend gracefully
To:     youling257 <youling257@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, hdegoede@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could you collect more logs w/ dynamic debug and post on the bug?

Dyndebug instructions:
https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html

Please enable debug for files hci_core.c, hci_request.c and hci_event.c:
(for example: echo 'file hci_core.c +p' > <debugfs>/dynamic_debug/control)

Thanks
Abhishek

On Thu, Apr 9, 2020 at 10:08 AM youling257 <youling257@gmail.com> wrote:
>
> This patch series cause a suspend problem on BYT/CHT device, https://bugzilla.kernel.org/show_bug.cgi?id=207169
