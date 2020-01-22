Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5EBC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 21:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A16A21835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 21:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="QS/qOUvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgAVV2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 16:28:53 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44184 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729251AbgAVV2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 16:28:52 -0500
Received: by mail-lj1-f194.google.com with SMTP id q8so679374ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 13:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=USiqOlQcAGwAU4lLldkez+ILA+mr5UwSGgb0G/ckznI=;
        b=QS/qOUvdayAU3GPaH8DxPbsbrNRZDZgVX+N4uafont01yWgzRvNuaFkQixghM4fGLg
         9QPae3sdC8aYt6XfPuKVLoGF3M3eLlanCkm7mOTAim8uX1TjswA7LDLLQU14TffVzWdL
         Gy9J9dPV8pMcDKfo7PBT20X86WJTDcuCysfZzYiyO8iVVUDKmXXQ13+YWtnAV8YsOto3
         3Ty31Pi58oev8GCNTTYg+MQWArZpl218/1U4l+ULrfBMQSKpN5zG0Cig5Syq7cV4Xzcb
         +acWuAjXOi/UTiHtnm0IyK6exGOs32jN8dCIv/3RCJnZy70o6IozMJs4uAFIHKeXAuLW
         +jjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=USiqOlQcAGwAU4lLldkez+ILA+mr5UwSGgb0G/ckznI=;
        b=umsaehnlwGyFQiT5aVde2l+nzBMheMZKE0s8tm3uA2mAScxTVNtAHonbw5MzYGbjg5
         8VhRl89+ezpoqiTf3Fpe2346WtTQUVn/0yPRBto9ooW3cD6FHmJ0xyixukyD0ZJY8ObC
         NNkj5XXBQ7UZeTOc72yQswmMSIc4BHTF5id3OJSXrg1vqVzMXVQ6SypqZPk8NmX9byvJ
         DVKG3nCvR83YIVz1NXIy11igioFoMi3a8HE72qTKRERkXoGfdswlMYL7J/hS1LRGlN2V
         fqH8TOtq3ena5gHpDdpeYUe4R8NJSLWSmYS9yCTvO4Bv2md7NjWHL8FEi0lDAYvq546W
         SB4g==
X-Gm-Message-State: APjAAAW9ypcWHgTUCGL5GaXHONfD24GlHu+KGfsmVrkvhqcm2Xq19EpU
        m7+ffE9q/+9GN1LKnHILe9UoNiRxhERhCEdk0tmr
X-Google-Smtp-Source: APXvYqxv+HwClvqbjPOmF70g6vWAGoqQq5nvKaKJ9i+5808mWnhq6PoDHjQ2dbc6K34/pUaYI6i8SCPyRPmgc0tTqfs=
X-Received: by 2002:a2e:870b:: with SMTP id m11mr20501589lji.93.1579728530781;
 Wed, 22 Jan 2020 13:28:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577736799.git.rgb@redhat.com> <7d7933d742fdf4a94c84b791906a450b16f2e81f.1577736799.git.rgb@redhat.com>
In-Reply-To: <7d7933d742fdf4a94c84b791906a450b16f2e81f.1577736799.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 22 Jan 2020 16:28:39 -0500
Message-ID: <CAHC9VhSuwJGryfrBfzxG01zwb-O_7dbjS0x0a3w-XjcNuYSAcg@mail.gmail.com>
Subject: Re: [PATCH ghak90 V8 07/16] audit: add contid support for signalling
 the audit daemon
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 2:50 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Add audit container identifier support to the action of signalling the
> audit daemon.
>
> Since this would need to add an element to the audit_sig_info struct,
> a new record type AUDIT_SIGNAL_INFO2 was created with a new
> audit_sig_info2 struct.  Corresponding support is required in the
> userspace code to reflect the new record request and reply type.
> An older userspace won't break since it won't know to request this
> record type.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/audit.h       |  7 +++++++
>  include/uapi/linux/audit.h  |  1 +
>  kernel/audit.c              | 35 +++++++++++++++++++++++++++++++++++
>  kernel/audit.h              |  1 +
>  security/selinux/nlmsgtab.c |  1 +
>  5 files changed, 45 insertions(+)

...

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 0871c3e5d6df..51159c94041c 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -126,6 +126,14 @@ struct auditd_connection {
>  kuid_t         audit_sig_uid = INVALID_UID;
>  pid_t          audit_sig_pid = -1;
>  u32            audit_sig_sid = 0;
> +/* Since the signal information is stored in the record buffer at the
> + * time of the signal, but not retrieved until later, there is a chance
> + * that the last process in the container could terminate before the
> + * signal record is delivered.  In this circumstance, there is a chance
> + * the orchestrator could reuse the audit container identifier, causing
> + * an overlap of audit records that refer to the same audit container
> + * identifier, but a different container instance.  */
> +u64            audit_sig_cid = AUDIT_CID_UNSET;

I believe we could prevent the case mentioned above by taking an
additional reference to the audit container ID object when the signal
information is collected, dropping it only after the signal
information is collected by userspace or another process signals the
audit daemon.  Yes, it would block that audit container ID from being
reused immediately, but since we are talking about one number out of
2^64 that seems like a reasonable tradeoff.

--
paul moore
www.paul-moore.com
