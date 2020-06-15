Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7080EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4410F2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592229831;
	bh=gsoUVnafzddB7VBjTI7st/fE0HTYHfOxd6u34VPGn7Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=tM7YAlZ5RT0t4HmGn+I5u+dhXAUh8kL8Uuet0qGJTw+r1MOeIP/RwF27InxaJRfb2
	 16wkq5NylcnakXUnApboW+zLAxVUP+fZZpWwlXySqXe8xV505zDsCk7NGdMAsVYiHR
	 m6ptAtYmnGjscFHCiBH7Fi1hA2SogocOP25AQNzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbgFOODs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729962AbgFOODo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:03:44 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D4652074D;
        Mon, 15 Jun 2020 14:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592229824;
        bh=gsoUVnafzddB7VBjTI7st/fE0HTYHfOxd6u34VPGn7Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LBLry14oj60XR8cXXQLBUp6A+Vnc6b3qiHTE/OYPzT1DSxRGpEMJphbVs9gv24sPf
         yPsv2vIIwYM7NmlPWaW5YSwVrmu/f5ejj6Ocde3j5dCBOg6Vj3W7jVtQ5bXSkPKaKa
         8fT6Fhx3eSa49BaHwu7iHOzLSOocDUVQPzv2MtsI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E08853522EFD; Mon, 15 Jun 2020 07:03:43 -0700 (PDT)
Date:   Mon, 15 Jun 2020 07:03:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     cai@lca.pw, elver@google.com, linux-kernel@vger.kernel.org
Subject: Re: fastpath_t? __no_kcsan? Both?
Message-ID: <20200615140343.GC2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200615042002.GA14788@paulmck-ThinkPad-P72>
 <0bdd3592-24ae-ab35-a6cd-40d842b127e0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bdd3592-24ae-ab35-a6cd-40d842b127e0@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 09:12:56AM +0200, Paolo Bonzini wrote:
> On 15/06/20 06:20, Paul E. McKenney wrote:
> > 
> > I get the following conflict when rebasing 39a8c47635b0 ("kvm/svm:
> > Disable KCSAN for svm_vcpu_run()") onto v5.8-rc1:
> > 
> > <<<<<<< 6c410247efb2d3907b508a2448ab9ab1c86d938c
> > static fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
> > =======
> > static __no_kcsan void svm_vcpu_run(struct kvm_vcpu *vcpu)
> >>>>>>>> kvm/svm: Disable KCSAN for svm_vcpu_run()
> > The "natural" resolution would be this:
> > 
> > static fastpath_t __no_kcsan void svm_vcpu_run(struct kvm_vcpu *vcpu)
> > 
> > But does that make sense?
> 
> fastpath_t is just an enum, so
> 
> 	static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
> 
> Now that KCSAN has been merged however I can do this change myself.

Very good, over to you, and thank you!

							Thanx, Paul
