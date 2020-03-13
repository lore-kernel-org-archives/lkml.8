Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE1DC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5653A20724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAmYP74y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgCMM0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:26:09 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42894 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgCMM0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:26:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id t3so4186837plz.9;
        Fri, 13 Mar 2020 05:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TQY2dP5m8YWIYIwR1A/LK0PlPaEsfxw7E8OVjboitjQ=;
        b=tAmYP74yWEUEUSRtVwi97Pa3dhGvdU8PBoJPdSt9kIDXUL9CY4ABDPoKndyfj/9FOU
         64PLyMf/iqmK95p3M4agKwEZzHxFVcFmb1nQk/LD1229o3OQz4d3zFzRHEccTQgruRdE
         ED2o1f5zV464viVKxcayxIUURhDSZQaFNqRm/R50eQ6MspeqGfnY6npLp+4GnEjQOyXA
         DDxDUbv0sxjuQ431fKAPreidlHpdidrWYrnYLyBvtKvp0T7+ra3iikZRdimXgwb2VGFv
         gd7T5zrdoWYtdXT6p2urw5VpgNjEs5PM0xw7ehZ3nbz5nWXGl9vnQolGr2uE4rKM2jhA
         93NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TQY2dP5m8YWIYIwR1A/LK0PlPaEsfxw7E8OVjboitjQ=;
        b=LGpmFrAt/zSX54Wv+i0Sya/zQox6rozi3kDYRRltN/3kD1POdtWy8DsDYAHniIMKxK
         ZUU/nzDgssnvtpDkLacCdsQDg4V7VEUEm3YsALrkm6cWMOfmddY8Rj8lNFG+1qbmM9d/
         +9TMxCZ8UrFGxEk/1Vfv2Z5scTJ0JJUKK8qPdrp1hIOEW3n2gqdpEHsJnHFXTBbDoQQI
         af9Vf5ElDZ7V7oKbXT1xj1z6+myZrPCF1t+PDe6gjlNRU3QOZPS5TnhdScZmWflnvI9D
         ajs5CSG9wgrUWV8qpqdaRUbPWUCibV5jddU3j5jPDTzVY0vc3Fd3d3rf4bQ1GuAMCYb0
         wudA==
X-Gm-Message-State: ANhLgQ20gcPr/NhJNHp3rq6p3EsxHjYBw6C8CNnjog+AoSIxO1B5qp4b
        HaEMuV2NvQHu+WtpCd9+zHU=
X-Google-Smtp-Source: ADFU+vuxBj8OnXD7isuulTA2PuIUUyBnrsGgMuSG8s3OCakVxkvSxvHVUCWtP5fcxVCouGfW0c+XGQ==
X-Received: by 2002:a17:90b:f16:: with SMTP id br22mr1642887pjb.170.1584102367011;
        Fri, 13 Mar 2020 05:26:07 -0700 (PDT)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id y13sm7286963pfp.88.2020.03.13.05.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 05:26:06 -0700 (PDT)
Date:   Fri, 13 Mar 2020 17:56:04 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Brian Cain <bcain@codeaurora.org>
Cc:     linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hexagon: replace setup_irq() by request_irq()
Message-ID: <20200313122604.GB7004@afzalpc>
References: <20200304004910.4842-1-afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304004910.4842-1-afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian Cain,

On Wed, Mar 04, 2020 at 06:19:09AM +0530, afzal mohammed wrote:

> Hi hexagon maintainers,
> 
> if okay w/ this change, please consider taking it thr' your tree, else please
> let me know.

Per get_maintainers script, there are no maintainers, only a support
in you, seems you are not sedning pull requests for hexagon. If you
are okay w/ this change, can you please ack it so as to be routed via
tglx.

Regards
afzal
