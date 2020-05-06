Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41E7C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD1D32082E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588808535;
	bh=gPcgj6HdXpoIfsTowrHYChJFHu1lH1/EjkkmN72nDfY=;
	h=Date:From:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:References:
	 List-ID:From;
	b=szc7w1jbSV2Ec/2RtRVR6Aeqf9YxMSdQnTdlfFTZTB4F7Yf8orjwG2806scTrk3E0
	 GVbGtrDcPY/1WjLtVHr90H7XkcAcK3nJKOgzcbIw8u8hwtiJSi4hNPT52mQoPT33tx
	 TA4z7O1g84FGP0+Ta7jDl5qa0Zqu+N3g5vmE9HPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgEFXmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 19:42:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbgEFXmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 19:42:10 -0400
Received: from localhost (unknown [137.135.114.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6BEB20746;
        Wed,  6 May 2020 23:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588808529;
        bh=gPcgj6HdXpoIfsTowrHYChJFHu1lH1/EjkkmN72nDfY=;
        h=Date:From:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:References:From;
        b=q8KjyjU9tNXznxBILYyHnunbN0XNaQEGvSwSn1LVH2UtO1rEeielMBqX/rJyrnvPW
         Wje4WWjShtUm64YIJlGp2qjWYwxr+WIMzI9KePAXrsa99lW2RPrcC0nJMGOIVJK7sq
         kSBx+rwGPYLlNQ6GLNT2Zno/vVtiye2yoQ5aos2c=
Date:   Wed, 06 May 2020 23:42:09 +0000
From:   Sasha Levin <sashal@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     stable@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 1/3] KVM: SVM: fill in kvm_run->debug.arch.dr[67]
In-Reply-To: <20200504155558.401468-2-pbonzini@redhat.com>
References: <20200504155558.401468-2-pbonzini@redhat.com>
Message-Id: <20200506234209.B6BEB20746@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag
fixing commit: 42dbaa5a0577 ("KVM: x86: Virtualize debug registers").

The bot has tested the following trees: v5.6.10, v5.4.38, v4.19.120, v4.14.178, v4.9.221, v4.4.221.

v5.6.10: Build OK!
v5.4.38: Failed to apply! Possible dependencies:
    Unable to calculate

v4.19.120: Failed to apply! Possible dependencies:
    Unable to calculate

v4.14.178: Failed to apply! Possible dependencies:
    Unable to calculate

v4.9.221: Failed to apply! Possible dependencies:
    Unable to calculate

v4.4.221: Failed to apply! Possible dependencies:
    Unable to calculate


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha
