Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AF7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12ECC2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPMNbr2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgF2SrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729132AbgF2Smw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:42:52 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F86C033C3B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 11:37:16 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id i14so17713836ejr.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 11:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iwjexUe6g3MgBE57x0AwTJYB+Tm1mR4Xc5V3Hpfp0Q0=;
        b=BPMNbr2saZvodqadONafw08F2hySjig25hblzKcpl4Dn0xdeMuAJDob+Hj8/e26XnW
         DcsrasfTyHgT8KAkwUeolszGnixcmMnYIE8upwFFBx3ce9FSI6+4bF66uZlIeO/IYnfR
         nKG6W1gtUsCNuWXnXti67445rUxPidn7R2448rSS8fOhA6OPz9hTN+9JZ1bGkvKjvOET
         f/Of69MzWFDlYi0WAMar+2iMf+Vf9KeLGwI7hmgPshMBgwV9SN3pybBp7tN/RZCinBap
         xt0HZrWg0pNjOJCFPyFfAmVzUL7cyakhsBGU59PquHibfr0OHjgGhkDaijqPOVeIGj/+
         uBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iwjexUe6g3MgBE57x0AwTJYB+Tm1mR4Xc5V3Hpfp0Q0=;
        b=c3PV9D1DtUthse7Pa55WczsmWXzkxAjFdcQ2mTzRIbdTxqOazLTSmo0QgtJ5erWdtp
         AfeeCP/TX+N353jSfnPbQcPAwlvvzFzfUX5FQPZNNpsvF4C+2sysp0qabPQcKVYoxXd4
         CRpGvCcEqJvCN0Yt54hSElvNxfHeaCYzz7KTMU6Ul0bN2Nl/JF3/e3etHOnS0rjynsh+
         MyEH9j/fLjbOx8D/Kr4h4+QvdZNism8HaTCg2fZMU8A1aF4rkihF/h6PctcJvqpiZn9j
         ozofFooq8Y9O+qHKmv5mSLtEUYIGPNigbsY/gKACJe/eIYcwtQnUJpWbJs8DB8ity+ww
         8kEA==
X-Gm-Message-State: AOAM532AFA9dbQ/9PB5RlrjAwONaptfRLV41gTVF1RlmnNIuFAF5P5Ye
        15RgYsgz0j8+JWDkxn2djdquPJOq
X-Google-Smtp-Source: ABdhPJzHwlH82W9y4w5C+kdkMDP/5EI41sxvEjHgizXEikHzsbh2cE8UepqlgbOi/jQSwv4PVxX9bg==
X-Received: by 2002:a17:907:100a:: with SMTP id ox10mr14644241ejb.351.1593455835070;
        Mon, 29 Jun 2020 11:37:15 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:4d36:64ba:210e:1576])
        by smtp.gmail.com with ESMTPSA id by20sm295745ejc.119.2020.06.29.11.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 11:37:14 -0700 (PDT)
Date:   Mon, 29 Jun 2020 20:37:13 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparse: use static inline for __chk_{user,io}_ptr()
Message-ID: <20200629183713.msrfozjvpt6jr6jl@ltop.local>
References: <20200628072019.67107-1-luc.vanoostenryck@gmail.com>
 <202006300219.fQMPm3tC%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006300219.fQMPm3tC%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 02:08:36AM +0800, kernel test robot wrote:
> Hi Luc,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on next-20200626]
> [cannot apply to linux/master linus/master v5.8-rc2 v5.8-rc1 v5.7 v5.8-rc3]
> [If your patch is applied to the wrong git tree, kindly drop us a note.

This patch should be applied on top of akpm's tree or on top of next.
I'm not sure hwo I should have specified this, 'git send-mail --base=...'
is less useful for these trees.

-- Luc
