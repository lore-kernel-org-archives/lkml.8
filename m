Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09EAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7284B206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="YlnHXxlY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgFASG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730431AbgFASGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:06:16 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E29C08C5C0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 11:06:13 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id bg4so269828plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 11:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=poRdmI3sV+WAEeJ184sPC3DagggHtzKjgaeE5Yaw6wQ=;
        b=YlnHXxlYl+SOpQEvQznxQyGnf0ez8Fe1+z7AtuhnP2bvUCbA+Qk7QQd1dLs3Eiysuo
         4vE7UVP7MaUmLVsZQLm2mHFJhn38CeQLyyAlYMALNdsJoWPrW/UIiWU9X1ob+uqAul0z
         m7n/XC9dg7d5B7Synzd1nnRm6RGB5QZiJhjyaUi9s3OFeC2joTZKXBCrk+p06NU9Nnkx
         scmWPuCn9EJT4J9XtA/PHwhDZ2xjLWlZ5y5m1OG22yb4yLPIUuCudz7CEbSFIDjCsXNH
         B4mkRHuCuHOFN0bOoOtSyuStK15jLiQg9cOq97m7omdsotrNbjvP0onlubU/D370uvu3
         iTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=poRdmI3sV+WAEeJ184sPC3DagggHtzKjgaeE5Yaw6wQ=;
        b=j3U7YkRRXtfCtEjZYZH/QxjGf6m/HgDQRC4aHKc9/yI9g2IWVYBMuta34906I7+CoL
         c9nsFMATwxjx2dE6qX/0JorZ9J6Lh9N/YnOf9cbx2zOITteuOYhr1vQV98vUtfc0HvqJ
         OWYCxtsXiDhgwsWrLnysSFWCREXHWx4+flnBf21aTtiT0NBwoOTnd/r58yaXX8IQJ1Vf
         kBeqClVETL9vt5yT6+zYqeCM7dzLiyWNEMf2UIAUnkBL296yuzrh2MYok3dinzB8O31O
         eXA/hi9RcfUyf9ZfumbpeynrodW01h9uCrVWl8zhJnrkL7grsCYjEWOC7Rj8zl97fwtl
         zoVQ==
X-Gm-Message-State: AOAM531tEHzqKwJJkqD5doMRCzS0P4qhs1J6PKdCAuBp5Jd972RGueqK
        lVjOggwClFqzUsY3QtV5luE42g==
X-Google-Smtp-Source: ABdhPJz9pyZqkmO3A0oC3+WeIAYCaVJwUVVxWnY8RVi4WTC5OtCQrLGgDuTlu/2Hs13GiYFNcTBnXA==
X-Received: by 2002:a17:90b:78b:: with SMTP id l11mr597420pjz.97.1591034772292;
        Mon, 01 Jun 2020 11:06:12 -0700 (PDT)
Received: from kaaira-HP-Pavilion-Notebook ([103.113.213.174])
        by smtp.gmail.com with ESMTPSA id a16sm118713pgk.88.2020.06.01.11.06.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Jun 2020 11:06:11 -0700 (PDT)
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
X-Google-Original-From: Kaaira Gupta <Kaairakgupta@es.iitr.ac.in>
Date:   Mon, 1 Jun 2020 23:36:03 +0530
To:     Helen Koike <helen.koike@collabora.com>
Cc:     Kaaira Gupta <kgupta@es.iitr.ac.in>, linux-media@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, kieran.bingham@ideasonboard.com,
        laurent.pinchart@ideasonboard.com,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: vimc: Add color descriptions to test image
Message-ID: <20200601180603.GA23904@kaaira-HP-Pavilion-Notebook>
References: <20200601135339.GA16606@kaaira-HP-Pavilion-Notebook>
 <dd4e19e7-285b-dced-bc0d-5aca38019b44@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd4e19e7-285b-dced-bc0d-5aca38019b44@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 01:36:59PM -0300, Helen Koike wrote:
> 
> 
> On 6/1/20 10:53 AM, Kaaira Gupta wrote:
> > Hi!
> > 
> > Currently there is no method to know if the test image generated by vimc
> > is correct (except for comparing it with a known 'correct' image). So, I
> > wanted to investigate about a possibility to add text to each color bar
> > of the generated pattern. I think currently vivid supports this
> > functionality as an optional control, so can we move it to a common 
> > platform so that both VIVID and VIMC can supoort it?
> > 
> > Thanks,
> > Kaaira
> > 
> 
> If it is useful I don't oppose, but I'm not sure how this is implemented
> in vivid (or if it is in tpg).
> I guess it is easier to judge from an RFC code :)

I am sorry for the confusion. Kieran pointed it out to me that vivid
does not print the values of colors to check if they are right or not.
It prints other useful information. As for vimc we want the order of
test image color to be printed so that it can be checked if the visible
order is correct. 

> 
> Regards,
> Helen
