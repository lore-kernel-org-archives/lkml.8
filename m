Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9265AC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 19:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A64220707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 19:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580497418;
	bh=FZtrXSUq54YseBjL3Heq3iDC0oP9DCIjuSPz9tmHKfo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=N0w1RY84zHlXVo55qNBBPEGsZTFGiS6AIvfy8yneaSC/WluSC4tfHiPKCV3Ar0WZq
	 j5sUgO/a8WTkrIiBc11wDs0KuqpddNFwOt3rJiZO/GfYEAVfOu+Wb45EGcqBn/vNpK
	 v+cXQ0WtID+Q32xB+rsyd4SFQaP8ojuMPNVgtlWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgAaTDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 14:03:37 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36564 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgAaTDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 14:03:37 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so8211677ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 11:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4VxK/MMCQW+dDkX8QecLocFy8dYcEu2g9dKlDlJzkls=;
        b=Q9Evdpky0V2PYOXzxUeE+Z0wqX2lKAGCp3nVViRW/lRXQ5YgmyuYZxzqoAY8Wyhmwm
         dQUvSnIuv5+2JkLzQBDvrI9/mHezfih4rZs5oNUSWIgveXLWll3Xv8Ze288fwOVtZRfN
         97QULoaV14HQwzYfA78+hJCh/lzyKFL4WmevU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4VxK/MMCQW+dDkX8QecLocFy8dYcEu2g9dKlDlJzkls=;
        b=Z/izaE2iIdtFuVw6okrrLYuPx56tAWSGjzlNfurk5dGEhQhycYaYRkjcUyjOd6Y4v+
         HfPWaW3nbHc+NOMzO2wlwRMUi6cGGdKwPyCwMR2dB1XKHg1TGsZVUPiIhptzrTaVPqEU
         G40BBSa8iUwcaX1gp4QK4fm+Sa1ZaE+7wp4TEM4L1oxJQ/kx4y/uAgX3tNvz35g17UM/
         dBsq3KppGzOAaHWebZKWQnSOzTzRYJ2Hiy8faRIbgoF3XCv5ONVqO5z097icgby3MTeI
         G+1tedgGduis6sToyTYbAWTeJ4f3tjIdLBsxeix1tlPMSAfCpo+HTwEvdN8NOJA4GJMG
         HsiQ==
X-Gm-Message-State: APjAAAUuiEvPqVhLpq3fjYiEIcMijQrq4teKwW9RvnYfNV6uTFVXZoP9
        N3W3dvHCKcH/6Ytf6/jcLEZ+tha+diU=
X-Google-Smtp-Source: APXvYqy+GRzUDdeeoR2dKozCknJoDC0gulkS1gJ5IqHoL1Jddc2TnA9YsCotCnNhbHsXnsceMZdhFQ==
X-Received: by 2002:a2e:9e43:: with SMTP id g3mr6855200ljk.37.1580497414468;
        Fri, 31 Jan 2020 11:03:34 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id m13sm5059048lfo.40.2020.01.31.11.03.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 11:03:33 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id d10so8162909ljl.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 11:03:33 -0800 (PST)
X-Received: by 2002:a2e:461a:: with SMTP id t26mr6842099lja.204.1580497413314;
 Fri, 31 Jan 2020 11:03:33 -0800 (PST)
MIME-Version: 1.0
References: <1580408442-23916-1-git-send-email-pbonzini@redhat.com>
 <CAHk-=wjZTUq8u0HZUJ1mKZjb-haBFhX+mKcUv3Kdh9LQb8rg4g@mail.gmail.com> <20200131185341.GA18946@linux.intel.com>
In-Reply-To: <20200131185341.GA18946@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 31 Jan 2020 11:03:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjoLqJ+zQQq2S3EmoAjOsY700GAPTCkna-RUG0T+4wYqA@mail.gmail.com>
Message-ID: <CAHk-=wjoLqJ+zQQq2S3EmoAjOsY700GAPTCkna-RUG0T+4wYqA@mail.gmail.com>
Subject: Re: [GIT PULL] First batch of KVM changes for 5.6 merge window
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Borislav Petkov <bp@suse.de>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 10:53 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> I assume the easiest thing would be send a cleanup patch for vmxfeatures.h
> and route it through the KVM tree?

Probably. The KVM side is the only thing that seems to use the
defines, so any names changes should impact only them (we do have that
mkcapflags.sh script, but that should react automatically to any
changes in the #define names)

And this is obviously not a big deal, I just noticed the discrepancies
when doing that resolution.

                    Linus
