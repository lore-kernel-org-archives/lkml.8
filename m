Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84AEC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBD82080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqQjkBxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgCXKZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:25:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55858 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgCXKZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:25:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id v25so715616wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 03:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LGUT3817m9dwKpwcgiwDpk5iBVynd8BwaSr3esU1DVk=;
        b=nqQjkBxQq4SmF2eCBrJZzQSJadKYuiApD6sLS+K5WWogPn0aWVPYOliY7P5ZnqmlqP
         Qs+X1WJJKib2E770uVyb0mp59LdlV9RJ00WoQqkaOwrSDBTSBtmxVQX7Xv6JTBsev/uF
         WzMexXe2iqzX4VMmwg3KfGSS7nxLYktDIpikFryUTbUFmjp2JBmkTajGCNAaTLiU6nGH
         06UG8o53k36hd+F4u0dwG/bqIKO6ITxnKPUY1j5+pyH1zuPM4qgw7P5ypTOJ3p/AiUH+
         cErRkLv0Hmjc3HkymikCdUfKXK6J0t28LUYI2cZLZraXlDCdpwrZIoCPyZhMduk0HS8C
         ppcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LGUT3817m9dwKpwcgiwDpk5iBVynd8BwaSr3esU1DVk=;
        b=ruINzDviT6vpmrw4RtxMUPqrXc3g9xiCt2ChMX0h+9c28QOLkUZvdzkvLm7nPMKWsM
         HZ9dXUp+Hg7/MF01sBH+BVFbJbbfop+3/TGcqDOQn3GyvP1zFSx7cWv2ZCGCW5VX5RcH
         nLWIUhhGA18VbL3zeAP4uL9MNs8o1crUSFSd6sy56xoy4h9Ow97isiptu5gDeG8XApLW
         lAbZLxg77+xu6QbtssVyGiyuKrCAMuk7FDYiOIiUnd2w3JfYFunYtbaWbKvXn/omQXG+
         npbqbGmnP0rO7QwaTQFKq77aJJWsyY+ai0qIP2H0vbc8E/pYXqm42AbQj2DO0ls7zJDr
         HeUA==
X-Gm-Message-State: ANhLgQ05yXKx+9mwkvakae61m8GhvMLR7dCJP836/NMfFqrkkYolLVp3
        yZEBdYjhaTgVIlZNkErDj8I=
X-Google-Smtp-Source: ADFU+vvyCe3wYKRgESX6ZP/xX3EjW7zkB/m7qMqBuI2AgmS3QY9jKMFz4rSHz8KYcVak7Kmna/2mMQ==
X-Received: by 2002:a7b:cc96:: with SMTP id p22mr4880707wma.118.1585045515798;
        Tue, 24 Mar 2020 03:25:15 -0700 (PDT)
Received: from kbp1-lhp-F74019 ([46.189.28.41])
        by smtp.gmail.com with ESMTPSA id f9sm28268562wrc.71.2020.03.24.03.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Mar 2020 03:25:15 -0700 (PDT)
Date:   Tue, 24 Mar 2020 12:25:05 +0200
From:   Yan Yankovskyi <yyankovskyi@gmail.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Jan Beulich <jbeulich@suse.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [Xen-devel] [PATCH v4 1/2] xen: Use evtchn_type_t as a type for
 event channels
Message-ID: <20200324102505.GA4248@kbp1-lhp-F74019>
References: <20200323152343.GA28422@kbp1-lhp-F74019>
 <06458b85-fb66-faac-e75a-1ccefa848cb0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06458b85-fb66-faac-e75a-1ccefa848cb0@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 05:55:39PM -0400, Boris Ostrovsky wrote:
> 
> On 3/23/20 12:15 PM, Yan Yankovskyi wrote:
> > Make event channel functions pass event channel port using
> > evtchn_port_t type. It eliminates signed <-> unsigned conversion.
> >
> > Signed-off-by: Yan Yankovskyi <yyankovskyi@gmail.com>
> 
> 
> If the difference is only the whitespace fix

There were two more fixes: missing include in gntdev-common.h and
a variable initialization in bind_virq_to_irq (eliminates warning).
