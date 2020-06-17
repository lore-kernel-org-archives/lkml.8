Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CE6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C48521883
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="WlXbj9ju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgFQVP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgFQVP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:15:28 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8C5C061755
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 14:15:26 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p20so4081517ejd.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 14:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aF2QFHszBUveBEYuZ4El0wMTZ2oyuOvfLY0YCwJErgY=;
        b=WlXbj9ju55dGjHRzLb5C+A8WJ5rU77z376DVpc11si+Mfk0mgl/SUv0GjXDMTXTPU8
         fkUT4YuEl24pt0ed8H2rwHxZmwl+0En+63ihMhy6iz1uo1YOJOvbn2kgp6I+oeDe0cL+
         vrKCnZo8IFvhrHmrIOp3beUH7vYfUsZg+zPRk/xHGsG5Ltlg73jB9l3leAp6Gazgra1G
         Q1l8GejBcNKrpCet0IlhxN5hE1ntYGvElCeF9qBiPymC/Yyp7XGcu+jhviej5TLXWwTK
         bCtFSc518u83smtBb6UwaDe8klytUX6DaGAmo/MTPVi3nU+F3w9WqyVROlmEw7jPu7/b
         VCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aF2QFHszBUveBEYuZ4El0wMTZ2oyuOvfLY0YCwJErgY=;
        b=GqnMs/tOM8pltuaL4BkZNRW2Nfl4HoMScMZ1dIOGdFPIM2uZwXGL59pblLEvPfak9L
         pO8nf//PzR3SUe+TnNHnE0AoP8ULNi/jDlfkPj3pFqvR12GtutuxlIzVUFEZVru0AMYF
         kd1tiS7+TJjAKekI5kT1sadCZJxHLYSbppDrgOgjKGAt2VrkzzoMNQjw4pKa8ISlCRQr
         5naoj439/awMzEyw6WNq2uVp4IU6aYW2iVyKBHUjpc9z9Z3P46vPdfDFIvLIpC4IZvaZ
         pNi0t6YAHjgwYGTP1FrPzL6EBt/0t1lC9AuNVBfopzJS9K5LyYGYJdWwnm5frQid2t3U
         3Nzw==
X-Gm-Message-State: AOAM533aFoLV2CiQ4p21iQIJKwI0b+KEVkjwg5+6UVSkaEfRD6AB59oN
        5JVsFPqdmLiKbr76Zl0iA4LOPwiKb5k2ZJqBbac4
X-Google-Smtp-Source: ABdhPJwpQGCuUs9iFPAHM5LwSxMut1A4ihpgUz0qV9wJycHjByfPFJfNofYDt/VmT8F/+Bwr1wIS1cgTIhYY6STDwXU=
X-Received: by 2002:a17:906:ecef:: with SMTP id qt15mr1003538ejb.91.1592428525325;
 Wed, 17 Jun 2020 14:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200617204436.2226-1-nramas@linux.microsoft.com> <20200617204436.2226-2-nramas@linux.microsoft.com>
In-Reply-To: <20200617204436.2226-2-nramas@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 Jun 2020 17:15:14 -0400
Message-ID: <CAHC9VhTUd1N_W3Axr4PRt2qe56YfxeRiX17hqTnGJrJPVYNRWw@mail.gmail.com>
Subject: Re: [PATCH 2/2] integrity: Add errno field in audit message
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com, nayna@linux.ibm.com,
        sgrubb@redhat.com, rgb@redhat.com, linux-integrity@vger.kernel.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 4:44 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> Error code is not included in the audit messages logged by
> the integrity subsystem. Add "errno" field in the audit messages
> logged by the integrity subsystem and set the value to the error code
> passed to integrity_audit_msg() in the "result" parameter.
>
> Sample audit messages:
>
> [    6.284329] audit: type=1804 audit(1591756723.627:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel op=add_boot_aggregate cause=alloc_entry comm="swapper/0" name="boot_aggregate" res=0 errno=-12
>
> [    8.085456] audit: type=1802 audit(1592005947.297:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 op=policy_update cause=completed comm="systemd" res=1 errno=0
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> ---
>  security/integrity/integrity_audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
> index 5109173839cc..a265024f82f3 100644
> --- a/security/integrity/integrity_audit.c
> +++ b/security/integrity/integrity_audit.c
> @@ -53,6 +53,6 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
>                 audit_log_untrustedstring(ab, inode->i_sb->s_id);
>                 audit_log_format(ab, " ino=%lu", inode->i_ino);
>         }
> -       audit_log_format(ab, " res=%d", !result);
> +       audit_log_format(ab, " res=%d errno=%d", !result, result);
>         audit_log_end(ab);
>  }
> --
> 2.27.0

-- 
paul moore
www.paul-moore.com
