Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C20C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 13:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653932051A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 13:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mGy1O5WG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgBANa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 08:30:28 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:37596 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgBANa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 08:30:27 -0500
Received: by mail-ot1-f47.google.com with SMTP id d3so9339493otp.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 05:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4yXaP+LRwvGbnJ1oBUWO/6IuGMATcaiOWRj5DUBQkZc=;
        b=mGy1O5WG/tD3ojyVu95+/cXsxrs7yob/kKKG3B9zVOHLfM7/vj6HadS6BYUp84GcIz
         XY7eOfJm7sq3NSqx54cMlNaljd0pX6geQ7XRz7VF++0514woUxPyIHSkY1ICjxhLK2rn
         ntKeWlTXK3tb5coXbnqi8k4/rz99GzN/4xFKeLSkOOWVm2F97kmI2tHOaiONNW5h5AH/
         AAaLTgsBG62j3Ls0YzyHVC9hYpNC60/uxvw/RgBZPpSXoeiCs/6046VE3fUWA7GFSvgv
         SYmMtflo56jpLDabCa5y909GkkUOIGpiq7uFWL8IPtIt7EzO2WcPqh658ACbP4k8nbRO
         svFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4yXaP+LRwvGbnJ1oBUWO/6IuGMATcaiOWRj5DUBQkZc=;
        b=p9hkv+70BbFTIe/UlmwxckvNO9PTLE7XIyOH2Wu7YqAp7wRupl0kRXVQVuMFEqOEwL
         Ud6BR1MRGDCMjRmROBILB8qJ5D5xFe52LItmKBcfgfaPPfkL2flM9UBEZBl9w6/Tb/qk
         0554/QjKX47rcvN1jPGlyZoGRfZzVhbQIYY4xnE/TK1z4/yzbt+fi/ORfRbwacFV0Iqz
         D6BaVkL00vBdhyfUa6LHJDoGWFLvgi2t4H0drOJYf4adtfxxwqrn+agggpieZ7oL/vc4
         NRaWoTHHeZ3m/vL1/RePazbAiT2SedsZoVM2UeZp0jZsxDXlJd7+zeXlfYHKhTCgoqqF
         4a5w==
X-Gm-Message-State: APjAAAVKuFx+jqdki3u3m6ao5lf1zJxoms0rUXxcggdSHVTOsi0MbHpX
        3pUVXx5VhDFbgEU7W69TA6I9fR3fz2kREWThDyePrQ==
X-Google-Smtp-Source: APXvYqwkhM6QMY2sSNkbJDFdOXUjQFF1n3ICPf5aMAN4z/s8Xn6Y/knX56aoiFE+U39Y64v9cdVWaVWyzaObYRI1rco=
X-Received: by 2002:a9d:7b51:: with SMTP id f17mr11027322oto.302.1580563825300;
 Sat, 01 Feb 2020 05:30:25 -0800 (PST)
MIME-Version: 1.0
References: <CADVnQy=oFmmG-Z9QMafWLcALOBgohADgwScn2r+7CGFNAw5jvw@mail.gmail.com>
 <20200201060843.21626-1-sj38.park@gmail.com>
In-Reply-To: <20200201060843.21626-1-sj38.park@gmail.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Sat, 1 Feb 2020 08:30:08 -0500
Message-ID: <CADVnQymWFGfX-N_O=p_kqJ2UxQZUDVn1YKrzZ+C+hYWc_OuzMg@mail.gmail.com>
Subject: Re: Re: Re: [PATCH 2/3] tcp: Reduce SYN resend delay if a suspicous
 ACK is received
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>, sjpark@amazon.com,
        Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>, shuah@kernel.org,
        Netdev <netdev@vger.kernel.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, aams@amazon.com,
        SeongJae Park <sjpark@amazon.de>,
        Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 1, 2020 at 1:08 AM SeongJae Park <sj38.park@gmail.com> wrote:
> RST/ACK is traced if LINGER socket option is applied in the reproduce program,
> and FIN/ACK is traced if it is not applied.  LINGER applied version shows the
> spikes more frequently, but the main problem logic has no difference.  I
> confirmed this by testing both of the two versions.
>
> In the previous discussion, I showed the LINGER applied trace.  However, as
> many other documents are using FIN/ACK, I changed the trace to FIN/ACK version
> in this patchset for better understanding.  I will comment that it doesn't
> matter whether it is FIN/ACK or RST/ACK in the next spin.

Great. Thanks for the details!

neal
