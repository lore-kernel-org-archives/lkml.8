Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35FFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDB52075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qe6QhTRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391357AbgAXS3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:29:01 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:43685 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387714AbgAXS3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:29:01 -0500
Received: by mail-il1-f194.google.com with SMTP id o13so1723796ilg.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 10:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MzOM8tQ3sP2cY0Y79Mb3RBeF9aKri/D2BrjJwln0ZMk=;
        b=qe6QhTRtRrfS7XZjwODUAHPJVsjCM7EAv1BjXiq8vM+wyGaCkf4ErXr1JG2IlwFwOD
         u9RXwRrLDgt+3Al0S/p2qQa78Jqw8xeD6aw7OKJTdzYfO21xbkAMxuIBwXxB5oGdJDOR
         vgC7zdZzKXIxKofOKx4A4zZFsoy8v/4Vsv6ZFNGBkXSMNzkUBvMWq1x88QB6YZ8tLWDN
         PxgSBlWQpLAQDRCyl5VvPuB56xlaqSqwFl69bfgH2FHRS2YVyqD5fiP5lzC0g/RizWfR
         grFWnAsZ7bfZoCsMIIHYNFamLzeNBsDIigyYkDnz73UXkrbz/nLMOhHe8fwYy41V3B6X
         beNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MzOM8tQ3sP2cY0Y79Mb3RBeF9aKri/D2BrjJwln0ZMk=;
        b=ZR9TaEiY901IlbgDduritiLADBJvsmLi27es362EQd1IZoGbCcntFu0F2N+VtnqQWT
         7cHwKjwrXd65Roxnn7BbaK8q4Lt1/MHU3GiCt7fto3rfLQUFkWwocazrOK+T3gRsdbhV
         H7rseRBC3GICBaPyxd6UGUjPDtSqOLwQXqR/O9oudOyEXCQOW5lli3pcIs8N1xWZYn2+
         7MIYo2tfxCOw98lL5M+Y+4pDs4qhKe+4TJtg7XI/6MdjE8+2fTJ/ywqofB6NcpKfwlkn
         1/8KY5d28awUh3ADyFRk4y3L94cYIDBigyfmKZ7Ggqr/NKA3T/bR57kg+wwziW2k+Ti3
         a+hA==
X-Gm-Message-State: APjAAAWskBCLNiklMnOcORVz0+J+H+WAc94nNuEi1SbGfYDfhnkg2gNe
        +dUa36ZGJoB1J7l+Ja0KYnxa1x8FeoNnpDrC3+4=
X-Google-Smtp-Source: APXvYqxaAPHLhuxZk4MZgvxEeRmsPUpBjqMp5p2m0Tmj39XLUqYOZMT9HvIrl7aTnzyNTIZx4Cg0AGdcAuoquaxzo80=
X-Received: by 2002:a92:bf10:: with SMTP id z16mr4386101ilh.87.1579890540913;
 Fri, 24 Jan 2020 10:29:00 -0800 (PST)
MIME-Version: 1.0
References: <20200121183818.GA11522@bogus> <a9ec58818b5e0c982810e74efe3f5f22b930ae40.1579660436.git.viresh.kumar@linaro.org>
 <82e1181a-b1ff-eccc-d61d-2da0e7afec25@opensynergy.com>
In-Reply-To: <82e1181a-b1ff-eccc-d61d-2da0e7afec25@opensynergy.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 24 Jan 2020 12:28:50 -0600
Message-ID: <CABb+yY3ZrzgH8q8Nz+VGjz9X9GOs+1_RxB7qgtyeLTZd8BR_0w@mail.gmail.com>
Subject: Re: [PATCH V4] firmware: arm_scmi: Make scmi core independent of the
 transport type
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Peng Fan <peng.fan@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ALKML <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 6:15 AM Peter Hilber
<peter.hilber@opensynergy.com> wrote:
....
>
> I would have preferred (to have an option) to use as data passing
> interface to the transport just the struct scmi_xfer. A transport using
> this option would not implement ops (read|write)32 and memcpy_(from|to).
> The transport would also not call scmi_tx_prepare(), but instead take
> data from struct scmi_xfer directly. The transport would use a modified
> scmi_rx_callback() to notify that it updated the struct scmi_xfer. A
> helper to derive the struct scmi_xfer * from the message header would be
> extracted from scmi_rx_callback(). The scmi_xfer_poll_done() would
> become an (optional) transport op.
>
+1
I have pointed out many times the SCMI needs to realize not every
transport layer can conform to its expectations, the scmi_xfer must
have some transport specific element to it. Or there would be
emulation/pretend modes implemented in controller drivers.
