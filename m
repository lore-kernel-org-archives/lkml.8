Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71A5C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88B5720748
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="uvIZzRIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbgIDJE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgIDJEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:04:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63889C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 02:04:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a17so5942398wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 02:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QQlbI4/cVI7lV7hmpd49lUjhwmM3E62iOV4cqjNwGn0=;
        b=uvIZzRIZ8Ta/evq70yFiIpea3is+5U8CJ9nTtuEUUcNENV0B9KxuB/r2ZQ8NyWo8Ec
         02jJ3Qv5D6JKzGhTt5xChE6RF7NmW0gbkNqfmNgaaatMC9v6cSuahhJ+KUByWXJoi6X+
         hy5LGjlqanMviM0eDBl7WqEtsKlayZcsMZnqsGhW4I/5t+b4k8yEiLfqanmtau4RacOc
         J8390HGbRm2BMU9cFF2CYt17O2lVTL2qGz6IcPXtxwIfj1mng/lyZSKPEsWr2CPva9AS
         Y5URDvdDivRXJmBwgwlxj3h73VteTp/0Qw+WcLChhLx0qDWo8SgDKSDx6kBApp1FcF6v
         Kv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QQlbI4/cVI7lV7hmpd49lUjhwmM3E62iOV4cqjNwGn0=;
        b=q8BGvBN8q2892D9iZAWb5HYDeM8kL4gxrytIJwsVR0vVL/54sRFmfasa51pglRophr
         dTQh/wBYKgjIZKOQchr+2EWzLJiaJk1biqY4wmV2ReBPuAySetxKQtqNxfKLngI8uY6/
         0hpE29UH9LFIors0UN9k08QNflC1SBMZx8pPlgALDXww2y7LlLh33ojULGUtOH2ZH2Pb
         E6Bi0lTuExDU4XCwqVntBBhbGLK1zCvHBT9KGvE5lBwhhADIJSTB73x3BYSj4Q+YAAp7
         w3fjXh5ekQIEoUt7IOFyqjM3X66Z6CVuaab8haRzcraCkA5AWc8SiEIW40+7F7FhE2X9
         Mfqg==
X-Gm-Message-State: AOAM531C4jOPyoCWEKQ3FMSXqz+soS+Y9UyDfK2AlJTONcjl1MoLUTxP
        hDlhhHEvVeuUzWJ5hNlH1AI80Q==
X-Google-Smtp-Source: ABdhPJxfyoJZKVMcXhqJqChAKVrrr3Jvl4NNXruYQrn2aqulkTGhG/b+BXeWgex+ilGgkjRTgn29nw==
X-Received: by 2002:a5d:518b:: with SMTP id k11mr6387051wrv.369.1599210292051;
        Fri, 04 Sep 2020 02:04:52 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id f17sm10323532wru.13.2020.09.04.02.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 02:04:51 -0700 (PDT)
Date:   Fri, 4 Sep 2020 11:04:50 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Moshe Shemesh <moshe@nvidia.com>,
        Moshe Shemesh <moshe@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next RFC v3 01/14] devlink: Add reload action option
 to devlink reload command
Message-ID: <20200904090450.GH2997@nanopsycho.orion>
References: <1598801254-27764-1-git-send-email-moshe@mellanox.com>
 <1598801254-27764-2-git-send-email-moshe@mellanox.com>
 <20200831121501.GD3794@nanopsycho.orion>
 <9fffbe80-9a2a-33de-2e11-24be34648686@nvidia.com>
 <20200902094627.GB2568@nanopsycho>
 <20200902083025.43407d8f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200903055729.GB2997@nanopsycho.orion>
 <20200903124719.75325f0c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903124719.75325f0c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Sep 03, 2020 at 09:47:19PM CEST, kuba@kernel.org wrote:
>On Thu, 3 Sep 2020 07:57:29 +0200 Jiri Pirko wrote:
>> Wed, Sep 02, 2020 at 05:30:25PM CEST, kuba@kernel.org wrote:
>> >On Wed, 2 Sep 2020 11:46:27 +0200 Jiri Pirko wrote:  
>> >> >? Do we need such change there too or keep it as is, each action by itself
>> >> >and return what was performed ?    
>> >> 
>> >> Well, I don't know. User asks for X, X should be performed, not Y or Z.
>> >> So perhaps the return value is not needed.
>> >> Just driver advertizes it supports X, Y, Z and the users says:
>> >> 1) do X, driver does X
>> >> 2) do Y, driver does Y
>> >> 3) do Z, driver does Z
>> >> [
>> >> I think this kindof circles back to the original proposal...  
>> >
>> >Why? User does not care if you activate new devlink params when
>> >activating new firmware. Trust me. So why make the user figure out
>> >which of all possible reset option they should select? If there is 
>> >a legitimate use case to limit what is reset - it should be handled
>> >by a separate negative attribute, like --live which says don't reset
>> >anything.  
>> 
>> I see. Okay. Could you please sum-up the interface as you propose it?
>
>What I proposed on v1, pass requested actions as a bitfield, driver may
>perform more actions, we can return performed actions in the response.

Okay. So for example for mlxsw, user might say:
1) I want driver reinit
    kernel reports: fw reset and driver reinit was done
2) I want fw reset
    kernel reports: fw reset and driver reinit was done
3) I want fw reset and driver reinit
    kernel reports: fw reset and driver reinit was done

>
>Then separate attribute to carry constraints for the request, like
>--live.

Hmm, this is a bit unclear how it is supposed to work. The constraints
apply for all? I mean, the actions are requested by a bitfield.
So the user can say:
I want fw reset and driver reinit --live. "--live" applies to both fw
reset and driver reinit? That is odd.

>
>I'd think the supported actions in devlink_ops would be fine as a
>bitfield, too. Combinations are often hard to capture in static data.
