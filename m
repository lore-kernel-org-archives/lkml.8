Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C58CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C2D120720
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589307013;
	bh=61xlZrbWPX41z1uM+eXXyvV3cA4LQt15Qefbitoigw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dX2Wtq3X6xfiklwjLlaBIdK1WNAgNwyl8Z9TUdBaWbU4w6Csr4+SH1uVwJyKO/4be
	 ShxRK+RSRgsGfFFNdIvrmyLPX3rVdBo4oFsbBA7fXusuMuvulGFH/yPo2t6RXbWL/+
	 JLlgW4/QmDQQ3jNLf5OQjb8ZVYcuW/piSTAzo+HA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbgELSKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 14:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgELSKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 14:10:12 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90EBD20673;
        Tue, 12 May 2020 18:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589307012;
        bh=61xlZrbWPX41z1uM+eXXyvV3cA4LQt15Qefbitoigw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JJHdGC9ygYypPUd1I+twur74mNYaZUQ5pYNNqdx9tjuuIEU2GYaDeDZZTRVkUQC50
         uDfivLe3wue3jJ1Ew65GmFha1KGg+MnX3VHgfI1sqh/yCETzZXRjuAXDG0hYbcoujs
         xrPLaO40i+XM3BsbP644u01c4jv06U8Kz0jAChGA=
Date:   Tue, 12 May 2020 13:14:46 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Sage Weil <sage@redhat.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rbd: Replace zero-length array with flexible-array
Message-ID: <20200512181446.GJ4897@embeddedor>
References: <20200507191932.GA15991@embeddedor>
 <CAOi1vP9GfENfy_D_iOeUrweUk2CTcz+2GXGg3M6y+bvQs_zqMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOi1vP9GfENfy_D_iOeUrweUk2CTcz+2GXGg3M6y+bvQs_zqMw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 09:54:12AM +0200, Ilya Dryomov wrote:
> 
> Applied (folded into libceph patch).
> 

Thanks, Ilya. 

--
Gustavo
