Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D970C52D55
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204E721D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOIpUz8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388852AbgB0O0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:26:52 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35106 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388212AbgB0O0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:26:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so1223669plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 06:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ycQ4OM0GuiKa4B6agMtr6e0DcA3u66okRRNHJak9QaQ=;
        b=iOIpUz8yFMYlcEm1UZYDNFzSJAykarKnN0dZBkN7DkYhUOowyXt7D4TMvTw2xJBRnq
         +GzAaKP+Tk45ZozBwVSlKcS0zXDyEyp786dqV2wzOsdEM96Lw7SFVDoJmyEWOa6UnHI8
         7912HltfPziYci9i1f5q1G0kAO9lOWY4p5SUCOmUFv+RUOIMfWcvfeNf5eIfnxfyo4YA
         fL17rHV1YKvr8N4y3K8n7Re0ZU1oriE+W4pDB1flp+zLgqx1z3H/bf0UlqPh3i1SE/uQ
         OPUUPdNZgfyeq9KTx/wySfgA0Nfqqe2cRiRmPur0TB66Xpdsg3G5qha/Kqr1rSDVZSFa
         2SDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ycQ4OM0GuiKa4B6agMtr6e0DcA3u66okRRNHJak9QaQ=;
        b=UpJrP43trXMDefkO2Wb0fxdzMk+e7wiH8qV035Ope3hURDDhTHOP/mrjjI6ChHiZpB
         hdiUsR2sMeM12pp415oK4pF7ChAEORxlVFszokd9jKoJY5/ortt9Ffa90MtoSdQ40NPC
         iraKMEHr75g1tJN7SMjPslMHR9RX523QfJ29GXHnBXVygC4xpAcBq8WMuyD4aGs2vzE1
         iz3JLU0YdlcD9ZaCjW0Y2kXbWA6hfU9CUbFRljhOt7JoIamNU2lQqrFopv+cx1cm1zbp
         T+Tfti3k8gYYIdm0tysBY8J3b6WJqYsrTqvQ6FKxKpSuHmnDjHvK8RzLeFfkS3aaRHLV
         Dpww==
X-Gm-Message-State: APjAAAVWu+aKONtieVvfuA/z92i5zfOr1rIx3SKqr0o4TjeHmD9+0sea
        o5YNu6Qkk3y2uKd2Jq08HVM=
X-Google-Smtp-Source: APXvYqxolMZqMWoY5TQziUPfnPR+KyZmZpb4dquHkMYZpkch3u5nJuNvgMtX3kN+YRhF59rVGoOL+g==
X-Received: by 2002:a17:902:7283:: with SMTP id d3mr20329pll.118.1582813606112;
        Thu, 27 Feb 2020 06:26:46 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id u1sm7303392pfn.133.2020.02.27.06.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 06:26:45 -0800 (PST)
Date:   Thu, 27 Feb 2020 19:56:43 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 14/18] x86: Replace setup_irq() by request_irq()
Message-ID: <20200227142643.GA5610@afzalpc>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
 <a3116b3b1a03a943cd89efd57d2db32284c3a574.1581478324.git.afzal.mohd.ma@gmail.com>
 <87v9nsmhjj.fsf@nanos.tec.linutronix.de>
 <20200227113648.GA5760@afzalpc>
 <87sgiwma3x.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgiwma3x.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Thu, Feb 27, 2020 at 02:29:54PM +0100, Thomas Gleixner wrote:

> Using scripting to find the spots and automatically convert them to
> something which is functionally and semantically correct is perfectly
> fine. But scripts neither have taste nor common sense.
> 
> So going over a scripted conversion and fixing non-sensical stuff up
> manually is a good thing.

> The easy route is fine for the initial step. See above.

Sure, i will do the changes as per your suggestion.

Regards
afzal
