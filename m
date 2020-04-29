Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C67C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 195662083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akJhlQ7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgD2NtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgD2NtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:49:01 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB81C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 06:49:01 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s10so2651096wrr.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 06:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=n8lKxmUxsiGv6ubji6UvJYO03/2kibipeNIU1RQEYHM=;
        b=akJhlQ7mjQ67Wg3NFdDQOGeq2A65ZjWUZXnWU33XJQOZKCzSbYJOKgacOnAdUuXkEl
         gzUdFzdXzSLpite/j+7TAZ8ZVwOAICPBuZGR6e8/eOguuuPnMF9VJwzw81djSH9K39ij
         FXqahMMuwILuJj/J5MQvN1OTKREVsspCbxYfzxs8SExmPl476iHmZjwj0VI7EIafA/8M
         5rVhfp5HukqKUirTB7QX3Udt487tv02O3kegEeQ/MtxmMCyTXtGgDSDSH5XN5OIjHZPO
         tTga/uEhWONfX7BhihkwaN0TpULz2XicKgLgV6UU7cKe/UJ/CF5emnz81nTniTUg5rbT
         bJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=n8lKxmUxsiGv6ubji6UvJYO03/2kibipeNIU1RQEYHM=;
        b=AS4DHBUdf7KVWj7i9CkTBL2Q9yp5nP/+HINUeZ7utl+KzKSQVFwXcs6cc3ntjV9sFa
         ukNt1wsABSLN78yJNuwiqzmqLvnDK7/ZLnkuOmpeOYhof9Ucc0s+z1PCvf4GFIJ0ayz6
         5+sRvKeWKbiAQW6whYeMpHJk9iXPPvbgDZjPrb8hNWBAY86M9/5pybtscGSZcLtxaRnw
         UgoKz44wiEwBZFdAMuMdh02eIJgZBnmwyD6eXxWHGDBo/NnsE/3KMWpg+OPIeorP+8uj
         CP7hXQM9Hc/KfMbFyDREy/7XoxxOUyuQNG28NTBpeeximxbBlMl+4ssQAPVQCt2O6sfD
         0NGA==
X-Gm-Message-State: AGi0PuYLeWqBcXiFp9Kq6UvTqbuTw51En1h7kgszzIgPozt2SIUPHWIP
        kOoHiQH436IbTSgmqESfeiM=
X-Google-Smtp-Source: APiQypJ0+TOSoM2vbXjlLHYkNjaRTwB7y1C1KVBK8TA2tSkihKoCH9RjaUWhvVRQXcieKrx/tYd7+g==
X-Received: by 2002:a5d:51c6:: with SMTP id n6mr39149084wrv.314.1588168139993;
        Wed, 29 Apr 2020 06:48:59 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.gmail.com with ESMTPSA id d5sm30566939wrp.44.2020.04.29.06.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 06:48:59 -0700 (PDT)
Message-ID: <f9e72d79a0e4739313a954de8325ea338d6bfc7e.camel@gmail.com>
Subject: Re: [PATCH v3 1/5] w1_therm: fix reset_select_slave. Creating
 w1_therm.h
From:   Akira shimahara <akira215corp@gmail.com>
To:     Greg KH <greg@kroah.com>
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org
Date:   Wed, 29 Apr 2020 15:48:58 +0200
In-Reply-To: <20200429134357.GA2132814@kroah.com>
References: <20200429133048.139402-1-akira215corp@gmail.com>
         <20200429134357.GA2132814@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 29 avril 2020 à 15:43 +0200, Greg KH a écrit :
> On Wed, Apr 29, 2020 at 03:30:48PM +0200, Akira Shimahara wrote:
> > Patch for enhancement of w1_therm module.
> >  - Creating a w1_therm.h file to clean up the code and documenting
> > it.
> >  - fix reset_select_slave function: w1_reset_select_slave() from
> > w1_io.c
> > 	could not be used here because a SKIP ROM command is sent if
> > only
> > 	one device is on the line. At the beginning of the search
> > process,
> > 	sl->master->slave_count is 1 even if more devices are on the
> > line,
> > 	causing data collision in the bus.
> 
> This should be three different patches, one to create the file by
> moving
> the code, one to document it, and the last to do the fix.
> 
> thanks,
> 
> greg k-h

Ok, I will do

Akira Shimahara

