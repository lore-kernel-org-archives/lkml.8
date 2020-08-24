Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2A7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A9EA2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrYn6ChM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgHXUsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXUr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 16:47:58 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F44C061574;
        Mon, 24 Aug 2020 13:47:58 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i2so4149290qtb.8;
        Mon, 24 Aug 2020 13:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6qVTT/lTyemypVn84B/66lwJKOYGTPiWtwOtnBEu3KI=;
        b=ZrYn6ChMVaBECzNromWUqWzVy0kV3SqYA0RpNyyYqhTg7vkj/kZFRCnBnpRLYRBc2d
         lGEqW813B1QVJKCTUsfQSw/qFEjdo1AdA4DqX6go9O4Do4yNGPSl/Gn5zJYz0wQtsCxl
         s50SKXjB5hp4oT9UrXf6MZ+JvPXjOsdBcZnqOgC4ZQpIHkDtFf3SpQyOsy+oEoIZaVjb
         YfGsY0Xpub8dW2r92g98IkM+fYuPFdQQ6yqzlD+jdF3ZM2r9q6jC2136MvUwSAjRKT6f
         iNUqCKyYf8i2PUXJAkFAS6Ao/nv7Dgjl28I5uQsNX/oiHMMSOlldq5u6BZsbQb/Hwot0
         5FgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6qVTT/lTyemypVn84B/66lwJKOYGTPiWtwOtnBEu3KI=;
        b=cJWa1IdK8Bda+t56lsm/JqLhBh6B7Woboar3C62c4BXFqVgs1yQjKwFnRoqwlfDDBM
         Rbs9BtEl9HYmrx/lfmeClzp+mZSRsvGfWaMHQappUWhQyJMG4ZTqTpF7zlJEry9wqYcW
         JH2dgzQ8X7q81GnHf3CVIrFB9jQ1ktwK9FjjN6ibnD5QfkBSfAlbLoppbwp/5MclsjgR
         aeB1bGR711qRkvhM2vmzfC2j0cKSkzXohwQVvzkRVJ5EwfO8dpD3qi2+aYkX8NUQTFjT
         9O4+oZONRs6QvDMtLQAc+t4caRVVuHrbV96O/4k/Qxbak9nIgsQcNJ6ghG4xTDxormS3
         AzeA==
X-Gm-Message-State: AOAM5309JYxNv9JFMJjYQrBJz7Z9bt0IgQOtwyvjyooylSjZacTRefIc
        rhnF7GnAP1oxk/tiVprqHko=
X-Google-Smtp-Source: ABdhPJzLqeFBNb9TwZIBurQ9p/DLgBsaRhoB5Vox/TDfAGpu+aGOlziubpcE5xt5enmOvF6cNfCLAg==
X-Received: by 2002:ac8:490d:: with SMTP id e13mr6361049qtq.198.1598302077587;
        Mon, 24 Aug 2020 13:47:57 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id 65sm10134995qkn.103.2020.08.24.13.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 13:47:56 -0700 (PDT)
Date:   Mon, 24 Aug 2020 13:47:55 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.4 000/109] 5.4.61-rc2 review
Message-ID: <20200824204755.GA1367979@ubuntu-n2-xlarge-x86>
References: <20200824164737.830839404@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824164737.830839404@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 06:48:46PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.61 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Aug 2020 16:47:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.61-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Built several configurations with LLVM 12 and saw no regressions
compared to 5.4.60.

Tested-by: Nathan Chancellor <natechancellor@gmail.com>
