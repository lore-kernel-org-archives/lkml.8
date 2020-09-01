Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDCCC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 523382071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tYjWjwxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgIARmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgIARmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:42:07 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38058C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 10:42:07 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 2so980209pjx.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 10:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oADnpVnhuzHJnPApJ9kIojrHq2eqkgYQRcAqIs0z0NY=;
        b=tYjWjwxPr0KmCCesr5cpdQVclvQX2lHtsn6mThnuSuwoIkTfTALNKOWdscS0oA+A5c
         WapSqTzs0o8TV8mfYcNhDS79CPLiX026NaMf9kWdbTCJeKw/T/xQmyP4E9/uXLyRcXJ2
         KeV5YBHMey+XSJCK/Crw64DBSCaN509bwNCgqAzczLOnX0ITSP2bwt+9WHllKCW+8YvE
         Smm3iD45iDt7iI4Ga+Zh11WmgsltN9OKT5VlYxOMgR/6eMM3dnE9CnfHT8q7mdmVYs1R
         1C23Vj2Xeo6uaXFa8XCdR6guZYfFTduAgAmolg6yXEUqGI+/34FqDp7vKi8kMRzKIN7f
         bI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oADnpVnhuzHJnPApJ9kIojrHq2eqkgYQRcAqIs0z0NY=;
        b=Nenwv7SgtvT2HD3a228+/qGf0U0vSR+WU8Hcf9d2OUUwLKjLHN2Gf3FJBNLAkKe2my
         H6sfAYXuZWtrsieGzwPHm1qLv0Qdwv45QVlyfAZFX5m9bSKDuKe2DyaLu9WlcoyxZZ4R
         Ex9Cxk1GLVIHBwDLyS6advyJELne7VWXGD9MlPsc27H8IBwzeC+G3vADQ+/PkmpWBCaH
         UehHq+4+xeEffkYk/ciLHpLd5WkdNA69LNZsj0VP5KQS4nM62NWcbrZ9xWfEYg1+jAj3
         nbTrkngbLrVePNL0MWLD023cSVNYAYNqOK8PZFtvn5Z+zzozXw9p2V/OaEVjFPx59prN
         3gHA==
X-Gm-Message-State: AOAM532GShSYNnl1JXZovjSEqLLTqvOycxbwDgx04ctpJ7onu56zJWkd
        4uXtF+KR2S9rOoawNhq41rlk6190AmfAqtaQ8kRTdw==
X-Google-Smtp-Source: ABdhPJxM50938pUVlUK9XqlpjvVyutM77s5En1MbJNd//hDIEsEqDJXdPcaXt0T87RXZE12W08Q/NMM4z13H4Qoiw8M=
X-Received: by 2002:a17:90b:889:: with SMTP id bj9mr2665819pjb.101.1598982126505;
 Tue, 01 Sep 2020 10:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200829153515.3840-1-trix@redhat.com> <20200901110244.GZ2639@vkoul-mobl>
In-Reply-To: <20200901110244.GZ2639@vkoul-mobl>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Sep 2020 10:41:55 -0700
Message-ID: <CAKwvOdkK12Af7hdzDYk2FD+0Y8fXwLviRL2Xxjatuk61O3JQjA@mail.gmail.com>
Subject: Re: [PATCH] soundwire: fix error handling
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Tom Rix <trix@redhat.com>, yung-chuan.liao@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        shreyas.nc@intel.com, alsa-devel@alsa-project.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 4:02 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> Hello Tom,
>
> On 29-08-20, 08:35, trix@redhat.com wrote:
> > From: Tom Rix <trix@redhat.com>
> >
> > clang static analysis flags this problem
> >
> > stream.c:844:9: warning: Use of memory after
> >   it is freed
> >         kfree(bus->defer_msg.msg->buf);
> >               ^~~~~~~~~~~~~~~~~~~~~~~
> >
> > This happens in an error handler cleaning up memory
> > allocated for elements in a list.
> >
> >       list_for_each_entry(m_rt, &stream->master_list, stream_node) {
> >               bus = m_rt->bus;
> >
> >               kfree(bus->defer_msg.msg->buf);
> >               kfree(bus->defer_msg.msg);
> >       }
> >
> > And is triggered when the call to sdw_bank_switch() fails.
> > There are a two problems.
> >
> > First, when sdw_bank_switch() fails, though it frees memory it
> > does not clear bus's reference 'defer_msg.msg' to that memory.
> >
> > The second problem is the freeing msg->buf. In some cases
> > msg will be NULL so this will dereference a null pointer.
> > Need to check before freeing.
>
> The change looks good to me, but the title of patch should be revised.
>
> The patch subject should describe the patch, in this case is setting
> pointer to null on cleanup, so an appropriate subject may be"
> "[PATCH]: soundwire: set defer_msg to null".
>
> Please revise subject line and update including the ack/reviews
> received

That's fair, I think
soundwire: fix double free of dangling pointer
would be most precise.


-- 
Thanks,
~Nick Desaulniers
