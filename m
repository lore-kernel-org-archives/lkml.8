Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFF0C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9720F222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AubtjwE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgBMSfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:35:19 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:44457 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbgBMSfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:35:19 -0500
Received: by mail-wr1-f49.google.com with SMTP id m16so7919033wrx.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 10:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gn9AT/x/J4ve3CsD8CW/X6xTGiAOXHx6BgJ0wFYzNTw=;
        b=AubtjwE7TBr63SakdGaBptTT5UjwwwIbYRsF0LS4FydHSeoJFGh6mhd0LTpKataWbg
         DMpn3gGfcZC5hIvXWl3tt9ZpAuAH0lTARgCViX83A6dJUKBt7lsg0Unm1xSF+J15+2L+
         zaUmMaSF1jDTqAucXpPvhKmcyiW8n7CXQbOKUxBRnK2tNuXRi8uIERUIFmlkSTf4XSGn
         nK0M6PC5sZE/XSjFjpDC0yeyVM1WJrw2gGBKjmVSisMroeY7ZFkfFXke0LlRv+cmguTF
         R+UJaiNcnBL4sNEPkKiwJEZvLg1QUtH7qSIyQheodSXx1qsx/HYeb4gpO4z+wvlvdV5B
         UwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=gn9AT/x/J4ve3CsD8CW/X6xTGiAOXHx6BgJ0wFYzNTw=;
        b=KkGtKf9cwuc8vuHpfBssNA8ynZk102VVaOuz53LvAnlGKPp0Q325rMhe3TpN7JB1Ve
         pFfFSGTmiE6m0xDRT8ufpEnFvCdqJGFXp6ff9oQD2lEqAv+g7np2SQ66otBrFaiQF781
         w/41ewvex0CvNo3KA9RqHb08QQO4ae2YTCWoIUnszeCjGZswCtP4tm2EDpvD/A9dDwMZ
         dD01sLI9tXAEyPGa7ChByVW6U19MTgjH+0Edwav1s0ncoPEhjqC/rPEXpgCy+ibutNlI
         KhdS5sf3G2wX99bsI9YtcQkDJINkCTSiyYis9NfPmHCwJsZcgU1+g4clSu37SvZlTsb5
         W0Hw==
X-Gm-Message-State: APjAAAXc3A7frUQYEJrgqYA9NBKviQxLPlI7sbx0CAdMeXkgc8iJOla0
        wdpOjlQXuhNfZgfdC+V9Q0k=
X-Google-Smtp-Source: APXvYqwak060V/XuVeI1T95FWNBGttsOmaNXGezcbV1/BFFg1BVckMwGL2ST+9bfurpujOEHMBAtnA==
X-Received: by 2002:adf:8296:: with SMTP id 22mr23257028wrc.352.1581618918064;
        Thu, 13 Feb 2020 10:35:18 -0800 (PST)
Received: from dumbo (ip4da2e549.direct-adsl.nl. [77.162.229.73])
        by smtp.gmail.com with ESMTPSA id 133sm4273999wmd.5.2020.02.13.10.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 10:35:17 -0800 (PST)
Date:   Thu, 13 Feb 2020 19:35:15 +0100
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Regression: hibernation is broken since
 e6bc9de714972cac34daa1dc1567ee48a47a9342
Message-ID: <20200213183515.GA8798@dumbo>
Mail-Followup-To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200213172351.GA6747@dumbo>
 <20200213175753.GS6874@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213175753.GS6874@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 09:57:53AM -0800, Darrick J. Wong wrote:
> On Thu, Feb 13, 2020 at 06:23:51PM +0100, Domenico Andreoli wrote:
> > Hi,
> > 
> >   at some point between 5.2 and 5.3 my laptop started to refuse
> > hibernating and come back to a full functional state. It's fully 100%
> > reproducible, no oopses or any other damage to the state seems to happen.
> > 
> > It took me a while to follow the trail down to this commit. If I revert
> > it from v5.6-rc1, the hibernation is back as in the old times.
> 
> Hmm, do you know which hibernation mechanism your computer is using?
> 
> --D

s2disk/uswsusp. Any other tool I could use as alternative?

Thanks,
Domenico

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
