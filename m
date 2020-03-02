Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B558C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FF3217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JfuSjJof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgCBX4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 18:56:19 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37898 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCBX4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 18:56:19 -0500
Received: by mail-lf1-f65.google.com with SMTP id x22so40685lff.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 15:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KE3WHx+fg3DotOG85JdL9ozA18748xJIC4YzeAbIJCE=;
        b=JfuSjJofWcwIa3gy4eg5XDjPZImXxKzCuW3Z36skK8iZ3ByCaK/Rkqb/CLN+SB6+OZ
         GBCnKO4SF8ftXx9Yh8tOvC1BAbrnckq0bmB+oGoD8HoZcTXzYAq8efg2jsXAP4f23gof
         k6eUePg3oI7+1fh0dcsWlV5iSHUevlfTefIWak4jqqaKO/8k48W9W/m30ilx55A4mZV6
         H8yE3oeQOMGyWY0ckoK0fyxG0sQIwI/+zKQfs0V3S0m5z4a45VeGsWC7854a6stDlCug
         GubQKdzBNxq15uScgxx1P+BjkGyfCvJNwoQ049L3xeT282t1UvdIjeRt6L/eMXFSt950
         ji+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KE3WHx+fg3DotOG85JdL9ozA18748xJIC4YzeAbIJCE=;
        b=GnwMVBAL6zuZdTtP7HgnVcLTt03ndf3oO1k16yO0/msVPG/t7fdig6ltmpMK370XnP
         H4iq14bfiuyCoHKbFnWvhYTR/iWzR5WQQpDLs0+wIEbdnUg0akCnvHhrmOSa1a3+AfGG
         K7VuNoFk0+K1JA7HAdKn5ggV/rbnEZ43S2f8hXFgH0s+LJDCKs3WeWu0w6XMwAKS7jhX
         j01EG1H9mhqKB7qz/3R8EberB5bQ/bfWRUFZ8rry5uY8W2CgHoIfqV39/gJoKg7QHe3z
         AMTJ3gYpuAxOZ8k6LoglZt65K1Vl5ZYH0MJojKKV7I50sIg6AHALi/8EvSUVhsT1F+px
         jzNw==
X-Gm-Message-State: ANhLgQ0VcYqWrpFHuBrdFo+OnlQPVVklYxUvR+EVKtIQActUS9UGVFJ1
        cy/46AzMcQpewUFLBtrr/RgJySOaLLfazxiexD1i
X-Google-Smtp-Source: ADFU+vvnqF2Yda7JBoegXw2cpEPPLY0woMH2CrU0Ncdh86IuoRlyM//C3KedW8E4G6fkGAcSDSlm+OdsPhcY9tTqENo=
X-Received: by 2002:a19:840d:: with SMTP id g13mr943582lfd.162.1583193376465;
 Mon, 02 Mar 2020 15:56:16 -0800 (PST)
MIME-Version: 1.0
References: <CAKT=dDnFpj2hJd5z73pfcrhXXacDpPVyKzC7+K94tsX=+e_BHg@mail.gmail.com>
 <20200302234840.57188-1-zzyiwei@google.com>
In-Reply-To: <20200302234840.57188-1-zzyiwei@google.com>
From:   Yiwei Zhang <zzyiwei@google.com>
Date:   Mon, 2 Mar 2020 15:56:05 -0800
Message-ID: <CAKT=dDkfG=STMf=htmazUDvsexedF+e-OqVVEgf_xtFj9XDrBQ@mail.gmail.com>
Subject: Re: [PATCH] [PATCH v4] gpu/trace: add a gpu total memory usage tracepoint
To:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Greg KH <gregkh@linuxfoundation.org>, elder@kernel.org,
        federico.vaga@cern.ch, tony.luck@intel.com, vilhelm.gray@gmail.com,
        Linus Walleij <linus.walleij@linaro.org>, tglx@linutronix.de,
        yamada.masahiro@socionext.com, paul.walmsley@sifive.com,
        bhelgaas@google.com, darekm@google.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-kernel@vger.kernel.org
Cc:     Prahlad Kilambi <prahladk@google.com>,
        android-kernel <android-kernel@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the noise here, there's a duplicate "[PATCH]" in the subject
line. Please refer to this one instead:
https://lkml.org/lkml/2020/3/2/1181
